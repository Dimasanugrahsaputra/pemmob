# Praktikum 8 — TabungKu Cloud

Proyek Flutter hasil `flutter create praktikum8`, dilengkapi backend FastAPI, MySQL 8.4, dan Docker Compose.

## Jalankan di Windows CMD

1. Buka Docker Desktop.
2. Masuk ke folder `praktikum8`.
3. Konfigurasi password di `.env` (buat dari `.env.example` jika belum ada).
4. `docker compose config`
5. `docker compose up -d --build`
6. `docker compose ps`
7. Buka `http://localhost:8000/health` dan `http://localhost:8000/docs`.
8. `flutter test`, `flutter analyze`, `flutter run`.

Emulator Android memakai URL `http://10.0.2.2:8000` (bukan localhost), bisa diubah lewat Pengaturan.
Untuk stop: `docker compose down` (jangan gunakan `-v` bila ingin mempertahankan data).

## Latihan mandiri
- `/info` sudah tersedia.
- Untuk simulasi port 9000, ubah compose `"8000:8000"` menjadi `"9000:8000"` dan alamat Flutter ke `http://10.0.2.2:9000`; kembalikan setelah uji.
- Buat tabel uji di MySQL, `docker compose down`, jalankan `up` lagi dan periksa tabelnya.
- Jalankan `docker images` dan `docker system df`; bandingkan image Python slim vs normal bila dibutuhkan.
