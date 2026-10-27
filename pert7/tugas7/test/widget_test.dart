import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tugas7/models/kegiatan.dart';
import 'package:tugas7/widgets/ringkasan_card.dart';

void main() {
  testWidgets(
    'Ringkasan menampilkan laporan yang benar',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RingkasanCard(
              ringkasan: Ringkasan(
                jumlahKegiatan: 4,
                selesai: 2,
                pemasukan: 50000,
                pengeluaran: 25000,
              ),
              target: 20000,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text('Rp 50.000'),
        findsOneWidget,
      );

      expect(
        find.text('Rp 25.000'),
        findsNWidgets(2),
      );

      expect(
        find.text('Kegiatan selesai 2/4'),
        findsOneWidget,
      );

      expect(
        find.text('Bagus! Target menabung tercapai.'),
        findsOneWidget,
      );
    },
  );
}
