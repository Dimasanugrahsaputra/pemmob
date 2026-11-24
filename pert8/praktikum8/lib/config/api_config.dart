import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ValueNotifier<String> apiUrl = ValueNotifier<String>(
  const String.fromEnvironment('API_URL', defaultValue: 'http://10.0.2.2:8000'),
);

const batasWaktu = Duration(seconds: 10);
const _kunciAlamatApi = 'alamat_api';

String? validasiApiUrl(String nilai) {
  final url = Uri.tryParse(nilai.trim());
  if (url == null ||
      (url.scheme != 'http' && url.scheme != 'https') ||
      url.host.isEmpty ||
      url.userInfo.isNotEmpty ||
      url.hasQuery ||
      url.hasFragment ||
      (url.path.isNotEmpty && url.path != '/')) {
    return 'Gunakan alamat dasar http://host:port atau https://host';
  }
  return null;
}

Future<void> muatAlamatApi() async {
  final prefs = await SharedPreferences.getInstance();
  final tersimpan = prefs.getString(_kunciAlamatApi);
  if (tersimpan != null && validasiApiUrl(tersimpan) == null) {
    apiUrl.value = tersimpan;
  }
}

Future<void> simpanAlamatApi(String alamat) async {
  final nilai = alamat.trim().replaceFirst(RegExp(r'/+$'), '');
  final pesan = validasiApiUrl(nilai);
  if (pesan != null) throw FormatException(pesan);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kunciAlamatApi, nilai);
  apiUrl.value = nilai;
}
