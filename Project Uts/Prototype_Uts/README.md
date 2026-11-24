# PUSTAKA - Flutter Android Studio

## Cara menjalankan
1. Buka Android Studio.
2. Buat project Flutter baru bernama `pustaka_online` (atau buka folder project hasil ekstrak).
3. Jika membuat project baru, ganti folder `lib` dan `pubspec.yaml` dengan yang ada di paket ini.
4. Buka Terminal pada root project lalu jalankan:
   ```bash
   flutter pub get
   flutter run
   ```

## Akun demo
- Email: `dimas@pustaka.test`
- Password: `dimas12345`

## Isi aplikasi
Welcome, login, registrasi, lupa kata sandi (simulasi), katalog, pencarian, filter kategori,
detail buku, pilih maksimal 3 buku, formulir dan konfirmasi pengajuan, status berhasil,
dashboard anggota, daftar peminjaman, tracking, riwayat, profil, dan edit profil.

## Catatan penting
Paket ini adalah implementasi Flutter sisi aplikasi dengan data contoh di memori (akan kembali
ke data awal saat aplikasi ditutup). Login, registrasi, reset email, status petugas, notifikasi,
stok lintas pengguna, pengembalian, dan denda belum terhubung ke server. Agar seluruh proses
operasional sesuai BRD/PRD, perlu backend Laravel REST API + database MariaDB dan panel admin
Filament v3. Figma PDF yang disertakan menunjukkan 16 layar utama; tampilan ini mengimplementasikan
alur layar tersebut sebagai dasar yang bisa dijalankan dan dikembangkan.
