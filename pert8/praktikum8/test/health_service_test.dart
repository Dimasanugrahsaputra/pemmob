import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:praktikum8/services/health_service.dart';

void main() {
  test('Health /health berhasil tanpa server nyata', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/health');
      return http.Response(
        jsonEncode({'status': 'ok', 'waktu_server': '2026-10-06T10:00:00'}),
        200,
      );
    });
    final data = await cekServer(client: client);
    expect(data.status, 'ok');
    expect(data.latensi.inMilliseconds, greaterThanOrEqualTo(0));
    client.close();
  });
}
