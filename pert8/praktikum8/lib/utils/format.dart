String formatTanggalDatabase(DateTime tanggal) {
  String dua(int nilai) => nilai.toString().padLeft(2, '0');
  return '${tanggal.year}-${dua(tanggal.month)}-${dua(tanggal.day)}';
}

String formatTanggalPanjang(DateTime tanggal) {
  const bulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];
  return '${tanggal.day} ${bulan[tanggal.month - 1]} ${tanggal.year}';
}

String formatRupiah(int nilai) {
  final angka = nilai.abs().toString();
  final buffer = StringBuffer();
  for (var index = 0; index < angka.length; index++) {
    if (index > 0 && (angka.length - index) % 3 == 0) buffer.write('.');
    buffer.write(angka[index]);
  }
  return '${nilai < 0 ? '-' : ''}Rp $buffer';
}
