# Perpustakaan — Prototype Flutter/Dart sesuai BRD

Project ini adalah konversi prototype UI/UX **Sistem Informasi Peminjaman Buku Online** ke Flutter/Dart untuk dijalankan di Android Studio.

## Cakupan prototype
- Beranda Pengunjung dan katalog publik.
- Login Anggota (simulasi lokal).
- Katalog, detail buku, pemilihan beberapa buku.
- Form pengajuan peminjaman dan tanggal rencana pengambilan.
- Riwayat pengajuan (status awal Diajukan).
- Profil Anggota.
- Data dan interaksi demo lokal; belum terhubung Laravel/MariaDB.
- `design_reference/` berisi frame prototype BRD sebagai acuan visual.

## Cara paling aman menjalankan di Android Studio (Windows)
1. Ekstrak ZIP ke folder yang bisa Anda edit, contoh `C:\Semester 5\pemmob\Project Uts\Perpustakaan_BRD`.
2. Klik dua kali `setup_android.bat` **sekali saja**. Script akan membuat folder `android/` menggunakan versi Flutter di laptop Anda dan menjalankan `flutter pub get`.
3. Buka Android Studio > Open > pilih folder project ini (folder yang berisi `pubspec.yaml`).
4. Pastikan plugin Flutter/Dart aktif.
5. Pilih emulator Android (misalnya Pixel 8), bukan Windows desktop.
6. Buka `lib/main.dart`, lalu klik Run.

Alternatif dari Terminal Android Studio:
```powershell
flutter create --platforms=android --project-name perpustakaan_brd_prototype .
flutter pub get
flutter run
```
Perintah `flutter create` hanya diperlukan jika folder `android/` belum ada.

## Penting
Ini adalah **prototype frontend** untuk UI/UX. Login, status transaksi, stok, email, pengembalian, dan denda belum tersambung backend nyata. Implementasi produksi harus menggunakan Laravel REST API dan MariaDB sesuai BRD.
