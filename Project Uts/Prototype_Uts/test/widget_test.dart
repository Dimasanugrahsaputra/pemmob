import 'package:flutter_test/flutter_test.dart';
import 'package:pustaka_online/main.dart';

void main() {
  testWidgets('Halaman awal Pustaka tampil', (WidgetTester tester) async {
    await tester.pumpWidget(const PustakaApp());

    expect(
      find.text('Temukan inspirasi baru.'),
      findsOneWidget,
    );

    expect(
      find.text('Masuk ke akun'),
      findsOneWidget,
    );
  });
}
