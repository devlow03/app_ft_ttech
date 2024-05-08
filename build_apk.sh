#!/bin/bash

# Đọc thông tin từ pubspec.yaml
APP_NAME="tmart"
VERSION=$(grep "version:" pubspec.yaml | awk '{print $2}')

# Xóa ký tự không mong muốn trong tên ứng dụng
APP_NAME_CLEAN=${APP_NAME//[^a-zA-Z0-9]/_}

# Tách số định danh từ phiên bản hiện tại
VERSION_NUMBER=$(echo $VERSION | awk -F '+' '{print $1}')

# Tách số build từ phiên bản hiện tại
BUILD_NUMBER=$(echo $VERSION | awk -F '+' '{print $2}')

# Kiểm tra nếu không có số build thì gán giá trị mặc định là 0
if [ -z "$BUILD_NUMBER" ]; then
  NEW_VERSION="$VERSION+1"
else
  # Tăng số build lên 1
  NEW_BUILD_NUMBER=$((BUILD_NUMBER + 1))

  # Tạo phiên bản mới bằng cách kết hợp số định danh và số build mới
  NEW_VERSION="$VERSION_NUMBER+$NEW_BUILD_NUMBER"
fi

# Thay đổi phiên bản trong tệp pubspec.yaml
sed -i "s/version: $VERSION/version: $NEW_VERSION/" pubspec.yaml

# Đặt tên cho tệp APK
APK_NAME="$APP_NAME_CLEAN-$NEW_VERSION.apk"

# Build APK với tên được đặt
fvm flutter build apk

# Di chuyển tệp APK đến thư mục đích với tên được đặt
mv build/app/outputs/flutter-apk/app-release.apk build/app/outputs/flutter-apk/"$APK_NAME"
