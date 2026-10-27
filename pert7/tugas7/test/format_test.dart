import 'package:flutter_test/flutter_test.dart';
import 'package:tugas7/utils/format.dart';

void main() {
  group('Format Tanggal', () {
    test('Format tanggal SQLite', () {
      final tanggal = DateTime(2026, 10, 26);

      expect(
        formatTanggalDatabase(tanggal),
        '2026-10-26',
      );
    });

    test('Format tanggal Indonesia', () {
      final tanggal = DateTime(2026, 10, 26);

      expect(
        formatTanggal(tanggal),
        '26 Oktober 2026',
      );
    });

    test('Format tanggal singkat', () {
      expect(
        formatTanggalSingkat('2026-10-26'),
        '26 Okt',
      );
    });
  });

  group('Format Rupiah', () {
    test('Nominal nol', () {
      expect(formatRupiah(0), 'Rp 0');
    });

    test('Nominal positif', () {
      expect(formatRupiah(20000), 'Rp 20.000');
      expect(formatRupiah(50000), 'Rp 50.000');
      expect(formatRupiah(1000000), 'Rp 1.000.000');
    });

    test('Nominal negatif', () {
      expect(formatRupiah(-5000), '-Rp 5.000');
    });
  });
}
