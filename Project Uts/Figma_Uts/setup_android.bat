@echo off
setlocal
cd /d "%~dp0"
echo =============================================
echo  SETUP PERPUSTAKAAN BRD FLUTTER - ANDROID
 echo =============================================
where flutter >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Flutter tidak ditemukan di PATH.
  echo Jalankan flutter doctor di terminal untuk mengecek instalasi.
  pause
  exit /b 1
)
if not exist android (
  echo Membuat folder Android sesuai versi Flutter yang terpasang...
  flutter create --platforms=android --project-name perpustakaan_brd_prototype .
  if errorlevel 1 goto :fail
) else (
  echo Folder android sudah ada. Melewati flutter create.
)
echo Mengambil dependency...
flutter pub get
if errorlevel 1 goto :fail
echo.
echo Setup selesai.
echo Buka folder ini di Android Studio, pilih emulator, lalu Run main.dart.
echo Atau jalankan: flutter run
pause
exit /b 0
:fail
echo.
echo Setup gagal. Baca pesan error di atas.
pause
exit /b 1
