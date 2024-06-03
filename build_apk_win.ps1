# Đọc thông tin từ pubspec.yaml
$APP_NAME="tmart"
$VERSION=(Get-Content pubspec.yaml | Select-String "version:" | ForEach-Object { $_ -split ":" })[1].Trim()

# Xóa ký tự không mong muốn trong tên ứng dụng
$APP_NAME_CLEAN = $APP_NAME -replace "[^a-zA-Z0-9]", "_"

# Tách số định danh từ phiên bản hiện tại
$VERSION_NUMBER = $VERSION -split "\+")[0]

# Tách số build từ phiên bản hiện tại
$BUILD_NUMBER = $VERSION -split "\+")[1])

# Kiểm tra nếu không có số build thì gán giá trị mặc định là 0
if (-not $BUILD_NUMBER) {
    $NEW_VERSION = "$VERSION+1"
} else {
    # Tăng số build lên 1
    $NEW_BUILD_NUMBER = $BUILD_NUMBER + 1

    # Tạo phiên bản mới bằng cách kết hợp số định danh và số build mới
    $NEW_VERSION = "$VERSION_NUMBER+$NEW_BUILD_NUMBER"
}

# Thay đổi phiên bản trong tệp pubspec.yaml
(Get-Content pubspec.yaml) -replace "version: $VERSION", "version: $NEW_VERSION" | Set-Content pubspec.yaml

# Đặt tên cho tệp APK
$APK_NAME = "$APP_NAME_CLEAN-$NEW_VERSION.apk"

# Build APK với tên được đặt
fvm flutter build apk

# Di chuyển tệp APK đến thư mục đích với tên được đặt
Move-Item -Path "build/app/outputs/flutter-apk/app-release.apk" -Destination "build/app/outputs/flutter-apk/$APK_NAME"
