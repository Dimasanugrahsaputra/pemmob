# Prototipe Sistem Informasi Peminjaman Buku Online — Sesuai BRD

## Status hasil

- `index.html` adalah prototipe interaktif offline dalam satu file, memakai data simulasi lokal. Buka di Google Chrome dengan klik dua kali.
- `Figma_Frame_PNG/` berisi 33 cuplikan layar: 19 layar mobile (M01–M19) dan 14 layar Admin web (A00–A13). PNG adalah gambar, bukan layer komponen editable.
- File Figma milik pengguna tetap berada pada URL `https://www.figma.com/design/ydYtfqP2aMfkTXZNJYPgB7/`. Prototipe baru **BELUM** disimpan ke file Figma tersebut karena akun Figma terhubung ke integrasi tidak memiliki hak edit pada file itu.

## Alur sesuai BRD

**Pengunjung / Anggota Android:**
Beranda Pengunjung → Katalog → Detail Buku → Login/Registrasi → Form Pengajuan Banyak Buku → Konfirmasi → Diajukan → Peminjaman Saya → Status / Riwayat / Denda / Profil.

**Admin web:**
Login Admin → Dashboard → Kelola Anggota/Kategori/Rak/Buku → Daftar Pengajuan → Setujui atau Tolak → Penyerahan Fisik → Catat Jatuh Tempo dan Dipinjam → Bukti Email → Pengembalian Fisik → Pulihkan Stok → Catat Denda dan Pembayaran Luring.

**Status peminjaman (HARUS PERSIS):** Diajukan, Disetujui, Ditolak, Dipinjam, Dikembalikan. `Ditolak` adalah cabang terminal.

**Aturan stok:** pada Diajukan tidak dikurangi; baru dicadangkan ketika Disetujui; stok dikembalikan sekali pada Dikembalikan. Email bukti disimulasikan sesudah Dipinjam, dan kegagalan email tidak mengubah keabsahan transaksi. Tarif denda/durasi pinjam tidak ditentukan angka tetap oleh BRD.

## Cara menguji HTML

1. Buka `index.html` di Chrome.
2. Klik **Jelajahi Katalog** → **Lihat Detail** → **Pilih untuk Dipinjam**.
3. Login sebagai Anggota (tombol Demo), atur jumlah buku, tanggal rencana pengambilan, dan catatan.
4. Klik Konfirmasi → Kirim Pengajuan. Periksa status **Diajukan**.
5. Klik **Web • Admin** → **Masuk Admin (Demo)** → Pengajuan → Lihat Detail → Setujui. Periksa stok berkurang.
6. Klik Penyerahan → pilih tanggal jatuh tempo → Konfirmasi Penyerahan. Status menjadi **Dipinjam**; email bukti tersimulasi.
7. Klik Pengembalian → pilih tanggal kembali → catat nominal denda (opsional, berdasarkan kebijakan simulasi) → Konfirmasi Pengembalian. Status menjadi **Dikembalikan**; stok pulih.
8. Klik Denda → catat pembayaran luring (opsional). Klik Bukti Email → simulasi gagal → kirim ulang.
9. Klik Android • Anggota → Peminjaman Saya → Detail. Periksa seluruh riwayat tanggal, status, dan denda.
10. Untuk cabang **Ditolak**, reset demo dan gunakan tombol Tolak pada pengajuan berstatus Diajukan.

## Memasukkan layar ke Figma

1. Buka Figma Anda dengan hak **Can edit** pada `https://www.figma.com/design/ydYtfqP2aMfkTXZNJYPgB7/`.
2. Impor PNG dari folder `Figma_Frame_PNG/` ke halaman baru bernama `BRD Prototype — Mobile & Admin`.
3. Gunakan **Frame (F)** untuk membungkus setiap gambar dalam Frame terpisah. Beri nama sama seperti nama PNG. Atur screenshot mobile pada lebar sekitar 412 px dan admin sekitar 1040 px sesuai proporsi.
4. Buka tab **Prototype**. Set flow starting point pada `M01_Beranda_Pengunjung`. Tempatkan rectangle hotspot transparan di atas tombol yang ingin diklik, lalu pilih **On click → Navigate to → [nama Frame tujuan]**. Gunakan `Instant` untuk transisi.
5. Untuk alur Admin, gunakan flow starting point lain pada `A00_Login_Admin`.
6. Setelah koneksi dibuat, klik ikon **Present** untuk menguji. Klik **Share → Copy prototype link** dan ubah akses menjadi **Anyone with the link → Can view** jika pengaturan tim mengizinkan.

## Peta koneksi yang disarankan di Figma

| Asal | Area klik | Tujuan |
|---|---|---|
| M01_Beranda_Pengunjung | Jelajahi Katalog | M02_Katalog_Buku |
| M01_Beranda_Pengunjung | Masuk | M04_Login_Anggota |
| M01_Beranda_Pengunjung | Daftar | M05_Registrasi_Anggota |
| M02_Katalog_Buku | Lihat Detail buku | M03_Detail_Buku |
| M03_Detail_Buku | Pilih untuk Dipinjam | M04_Login_Anggota / M08_Form_Peminjaman (jika sudah login) |
| M04_Login_Anggota | Masuk | M07_Dashboard_Anggota / M08_Form_Peminjaman (jika melanjutkan pilihan) |
| M04_Login_Anggota | Lupa Kata Sandi | M06_Lupa_Kata_Sandi |
| M04_Login_Anggota | Daftar Akun | M05_Registrasi_Anggota |
| M05_Registrasi_Anggota | Daftar | M07_Dashboard_Anggota |
| M07_Dashboard_Anggota | Katalog Buku | M02_Katalog_Buku |
| M07_Dashboard_Anggota | Ajukan Pinjam | M08_Form_Peminjaman |
| M07_Dashboard_Anggota | Peminjaman Saya | M11_Peminjaman_Saya_Diajukan |
| M07_Dashboard_Anggota | Profil | M17_Profil_Anggota |
| M08_Form_Peminjaman | Lanjutkan ke Konfirmasi | M09_Konfirmasi_Pengajuan |
| M09_Konfirmasi_Pengajuan | Kirim Pengajuan | M10_Pengajuan_Berhasil |
| M10_Pengajuan_Berhasil | Lihat Peminjaman Saya | M11_Peminjaman_Saya_Diajukan |
| M11_Peminjaman_Saya_Diajukan | Lihat Detail | M12_Detail_Status_Diajukan |
| M12_Detail_Status_Diajukan | Perubahan setelah Admin menyetujui | M13_Detail_Status_Disetujui |
| M13_Detail_Status_Disetujui | Perubahan setelah penyerahan | M14_Detail_Status_Dipinjam |
| M14_Detail_Status_Dipinjam | Perubahan setelah pengembalian | M15_Detail_Status_Dikembalikan |
| M11_Peminjaman_Saya_Diajukan | Jika Admin menolak | M19_Status_Ditolak |
| M17_Profil_Anggota | Informasi Denda | M16_Info_Denda |
| A00_Login_Admin | Masuk Admin | A01_Dashboard_Admin |
| A01_Dashboard_Admin | Menu Anggota | A02_Manajemen_Anggota |
| A01_Dashboard_Admin | Menu Kategori | A03_Kategori_Buku |
| A01_Dashboard_Admin | Menu Rak Buku | A04_Rak_Buku |
| A01_Dashboard_Admin | Menu Buku | A05_Manajemen_Buku |
| A01_Dashboard_Admin | Menu Pengajuan | A06_Daftar_Pengajuan |
| A06_Daftar_Pengajuan | Lihat Detail | A07_Detail_Keputusan |
| A07_Detail_Keputusan | Setujui | A08_Penyerahan_Buku |
| A07_Detail_Keputusan | Tolak | A13_Pengajuan_Ditolak |
| A08_Penyerahan_Buku | Konfirmasi Penyerahan | A09_Pengembalian_Buku |
| A09_Pengembalian_Buku | Catat Pengembalian | A11_Denda_Belum_Lunas (jika ada denda) |
| A11_Denda_Belum_Lunas | Catat Pembayaran | A12_Denda_Lunas |
| A08_Penyerahan_Buku | Status Bukti Email | A10_Status_Email |

**Catatan:** karena Figma versi PNG tidak mempunyai data nyata, perpindahan setelah perubahan status harus disimulasikan dengan koneksi antarscreen. Pada HTML, logika status dan stok sudah dapat dijalankan secara interaktif.

## Keterlacakan requirement

| Persyaratan BRD | Layar demonstrasi |
|---|---|
| FR-M-01 s.d. FR-M-03 | M01–M03 |
| FR-M-04 s.d. FR-M-06 | M04–M06 |
| FR-M-07 | M07 |
| FR-M-08 s.d. FR-M-11 | M08–M10 |
| FR-M-12 s.d. FR-M-14 | M11–M16, M18–M19 |
| FR-M-15 | Semua layar mobile |
| FR-A-01 | A00 |
| FR-A-02 | A02 |
| FR-A-03 | A03–A05 |
| FR-A-04 s.d. FR-A-06 | A06–A07, A13 |
| FR-A-07 s.d. FR-A-08 | A08 |
| FR-A-09 | A09 |
| FR-A-10 | A11–A12 |
| FR-A-11 | A10 |
| FR-A-12 | Simulasi pemisahan peran Android dan Admin |
| FR-I-01 s.d. FR-I-07 | Hanya representasi interaksi UI, bukan API atau email sesungguhnya |
