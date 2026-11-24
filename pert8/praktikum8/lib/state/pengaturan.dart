import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pengaturan extends ChangeNotifier {
  int _target = 20000;
  bool _modeGelap = false;
  String _warna = 'Hijau';

  int get target => _target;
  bool get modeGelap => _modeGelap;
  String get warna => _warna;
  static const pilihanWarna = ['Hijau', 'Biru', 'Ungu'];

  Color get warnaUtama {
    switch (_warna) {
      case 'Biru':
        return Colors.blue;
      case 'Ungu':
        return Colors.deepPurple;
      default:
        return Colors.teal;
    }
  }

  Future<void> muat() async {
    final pref = await SharedPreferences.getInstance();
    _target = pref.getInt('target') ?? 20000;
    _modeGelap = pref.getBool('mode_gelap') ?? false;
    final warnaTersimpan = pref.getString('warna') ?? 'Hijau';
    _warna = pilihanWarna.contains(warnaTersimpan) ? warnaTersimpan : 'Hijau';
    notifyListeners();
  }

  Future<void> aturTarget(int nilai) async {
    _target = nilai;
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('target', nilai);
  }

  Future<void> aturModeGelap(bool aktif) async {
    _modeGelap = aktif;
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('mode_gelap', aktif);
  }

  Future<void> aturWarna(String warnaBaru) async {
    if (!pilihanWarna.contains(warnaBaru)) return;
    _warna = warnaBaru;
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    await pref.setString('warna', warnaBaru);
  }
}
