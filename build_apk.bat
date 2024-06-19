@echo off
REM Đọc thông tin từ pubspec.yaml
set APP_NAME="tmart"
for /f "tokens=2 delims=: " %%a in ('findstr "version:" pubspec.yaml') do set VERSION=%%a

REM Xóa ký tự không mong muốn trong tên ứng dụng
set APP_NAME_CLEAN=%APP_NAME:[^a-zA-Z0-9]=_%

REM Tách số định danh và số build từ phiên bản hiện tại
for /f "tokens=1,2 delims=+" %%a in ("%VERSION%") do (
    set VERSION_NUMBER=%%a
    set BUILD_NUMBER=%%b
)

REM Kiểm tra nếu không có số build thì gán giá trị mặc định là 0
if "%BUILD_NUMBER%"=="" (
    set NEW_VERSION=%VERSION%+1
) else (
    REM Tăng số build lên 1
    set /a NEW_BUILD_NUMBER=%BUILD_NUMBER%+1

    REM Tạo phiên bản mới bằng cách kết hợp số định danh và số build mới
    set NEW_VERSION=%VERSION_NUMBER%+%NEW_BUILD_NUMBER%
)

REM Thay đổi phiên bản trong tệp pubspec.yaml
powershell -Command "(gc pubspec.yaml) -replace 'version: %VERSION%', 'version: %NEW_VERSION%' | Out-File pubspec.yaml"

REM Đặt tên cho tệp APK
set APK_NAME=%APP_NAME_CLEAN%-%NEW_VERSION%.apk

REM Build APK với tên được đặt
fvm flutter build apk

REM Di chuyển tệp APK đến thư mục đích với tên được đặt
move build\app\outputs\flutter-apk\app-release.apk build\app\outputs\flutter-apk\%APK_NAME%
