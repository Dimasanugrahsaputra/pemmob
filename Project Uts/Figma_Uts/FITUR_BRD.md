# Pemetaan Prototype Flutter ke BRD

## Mobile Pengunjung/Anggota
- Beranda publik dan katalog tanpa login.
- Login Anggota (demo lokal).
- Registrasi Anggota (demo lokal).
- Lupa/reset kata sandi (demo lokal).
- Katalog, pencarian, filter kategori, detail buku dan stok.
- Memilih satu atau beberapa buku.
- Jumlah eksemplar dan tanggal rencana pengambilan.
- Pengajuan tersimpan dengan status **Diajukan** pada demo lokal.
- Riwayat pengajuan dan Profil Anggota.

## Simulasi proses Admin
Dapat dibuka dari Profil > **Simulasi Admin BRD**.
- Diajukan → Disetujui / Ditolak.
- Saat Disetujui, stok simulasi dicadangkan.
- Disetujui → Dipinjam setelah penyerahan fisik.
- Dipinjam → Dikembalikan setelah pengembalian.
- Stok dipulihkan ketika Dikembalikan.
- Denda dicatat dan pembayaran bersifat luring.
- Bukti email disimulasikan setelah status Dipinjam.

> Panel Admin dalam project Android hanya untuk demonstrasi UI/UX. Implementasi BRD nyata menempatkan Admin pada dashboard web Laravel Filament.
