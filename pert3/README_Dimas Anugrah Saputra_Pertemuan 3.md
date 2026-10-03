# Praktikum Flutter Fundamental — Pertemuan 3

> **Mata Kuliah:** Pemrograman Mobile  
> **Praktikum:** Flutter Fundamental  
> **Pertemuan:** 3  
> **Nama:** Dimas Anugrah Saputra  
> **NIM:** 20240801064  
> **Prodi:** Teknik Informatika  

---

## 1. Gambaran Praktikum

Di pertemuan ketiga ini, saya belajar bagaimana menerima input dari pengguna dan mengatur data yang dapat berubah saat aplikasi dijalankan. Materi yang dipelajari meliputi `TextField`, `TextEditingController`, `Form`, validasi, dropdown, checkbox, serta `setState`.

Setelah memahami state dasar, materi dilanjutkan ke penggunaan `ChangeNotifier` dan `Provider`. Kedua konsep ini kemudian diterapkan pada aplikasi **Daftar Tugas** dan dikembangkan lagi menjadi **Daftar Belanja**.

Menurut saya, bagian penting dari praktikum ini adalah memahami hubungan antara **input, state, dan tampilan**. Data dari pengguna harus diproses dan disimpan sebagai state agar perubahan datanya dapat terlihat pada UI.

---

## 2. Tujuan Pembelajaran

Beberapa materi yang saya pahami dari praktikum ini antara lain:

- menerima input dari pengguna;
- membaca input menggunakan controller;
- membuat form dan validasi;
- memahami penggunaan `setState`;
- menggunakan `ChangeNotifier`;
- menggunakan `Provider`;
- membedakan `context.watch()` dan `context.read()`;
- melakukan navigasi antar halaman;
- membuat fitur tambah, ubah status, dan hapus data.

---

## 3. Input Dasar dengan TextField

Pada bagian awal, saya mencoba menggunakan `TextField` sebagai input data.

```dart
final _controller = TextEditingController();
```

Controller berfungsi untuk membaca teks yang dimasukkan oleh pengguna.

```dart
TextField(
  controller: _controller,
  decoration: const InputDecoration(
    labelText: 'Nama',
    border: OutlineInputBorder(),
  ),
)
```

Isi input dapat diambil menggunakan:

```dart
_controller.text
```

Teks yang sudah diambil kemudian digunakan untuk mengubah nilai `_salam` seperti berikut:

```dart
setState(() => _salam = 'Halo, ${_controller.text}!');
```

Dari percobaan ini saya memahami bahwa `setState()` digunakan saat state pada `StatefulWidget` berubah sehingga tampilan perlu diperbarui.

Controller juga perlu dibersihkan melalui `dispose()` ketika sudah tidak digunakan:

```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

---

## 4. Form dan Validasi

Setelah mencoba input dasar, saya melanjutkan praktik menggunakan `Form`.

```dart
final _formKey = GlobalKey<FormState>();
```

Key tersebut dipasang pada:

```dart
Form(
  key: _formKey,
  child: ...
)
```

Input form menggunakan `TextFormField`.

Contohnya:

```dart
TextFormField(
  controller: _nama,
  decoration: const InputDecoration(
    labelText: 'Nama lengkap',
    border: OutlineInputBorder(),
  ),
  validator: (v) =>
      (v == null || v.trim().isEmpty)
          ? 'Nama wajib diisi'
          : null,
)
```

Validasi dijalankan menggunakan:

```dart
_formKey.currentState!.validate()
```

Jika input tidak sesuai aturan yang dibuat, pesan kesalahan akan ditampilkan pada form.

---

## 5. Dropdown dan Checkbox

Pada form pendaftaran, `DropdownButtonFormField` digunakan untuk memilih jurusan.

Pilihan yang tersedia:

- Teknik Informatika
- Sistem Informasi
- Teknik Mesin

Nilainya disimpan pada:

```dart
String? _jurusan;
```

Nilai tersebut kemudian diperbarui menggunakan `setState()`.

Selain dropdown, digunakan juga `CheckboxListTile` untuk persetujuan pengguna. Statusnya disimpan pada variabel berikut:

```dart
bool _setuju = false;
```

Tombol daftar hanya dapat digunakan setelah checkbox dipilih.

Dari sini terlihat bahwa state tidak hanya berguna untuk menampilkan data, tetapi juga dapat mengatur perilaku widget.

---

# 6. Memahami ChangeNotifier

Setelah memahami `setState`, saya lanjut mempelajari pengelolaan state menggunakan `ChangeNotifier`.

Contoh data tugas:

```dart
class Tugas {
  String judul;
  bool selesai;

  Tugas(this.judul, {this.selesai = false});
}
```

Kemudian data dikelola oleh:

```dart
class TugasModel extends ChangeNotifier {
  final List<Tugas> _items = [];
}
```

Model memiliki beberapa method:

```dart
void tambah(String judul)
void toggle(int index)
void hapus(int index)
```

Setelah data berubah, dipanggil:

```dart
notifyListeners();
```

Contohnya:

```dart
void tambah(String judul) {
  _items.add(Tugas(judul));
  notifyListeners();
}
```

`notifyListeners()` digunakan untuk memberi tahu widget yang menggunakan model bahwa terdapat perubahan pada state.

---

# 7. Provider

Model kemudian disediakan ke dalam aplikasi menggunakan kode berikut:

```dart
ChangeNotifierProvider(
  create: (_) => TugasModel(),
  child: const MyApp(),
)
```

Dengan cara tersebut, `TugasModel` bisa digunakan oleh widget yang berada di dalam cakupan `Provider`.

Pada halaman daftar digunakan:

```dart
final model = context.watch<TugasModel>();
```

Jika hanya ingin menjalankan sebuah aksi pada model, digunakan:

```dart
context.read<TugasModel>().hapus(index);
```

Perbedaannya dapat dipahami seperti ini:

| Method | Kegunaan |
|---|---|
| `context.watch()` | Mengambil state dan mengikuti perubahan |
| `context.read()` | Mengambil state untuk menjalankan aksi |

---

# 8. Implementasi Daftar Tugas

Data tugas ditampilkan dengan:

```dart
ListView.builder(
  itemCount: model.items.length,
  itemBuilder: (context, i) {
    ...
  },
)
```

Setiap tugas mempunyai checkbox.

```dart
Checkbox(
  value: t.selesai,
  onChanged: (_) =>
      context.read<TugasModel>().toggle(i),
)
```

Saat tugas sudah ditandai selesai, judulnya akan ditampilkan dengan garis coret:

```dart
decoration: t.selesai
    ? TextDecoration.lineThrough
    : null,
```

Tugas juga dapat dihapus melalui:

```dart
context.read<TugasModel>().hapus(i);
```

---

# 9. Halaman Tambah Tugas

Untuk proses menambah tugas, dibuat halaman khusus untuk memasukkan data.

Navigasi dilakukan menggunakan:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const TambahPage(),
  ),
);
```

Data judul tugas ditampung menggunakan `TextEditingController`.

Sebelum ditambahkan, input diperiksa:

```dart
final judul = _controller.text.trim();

if (judul.isEmpty) return;
```

Kemudian data dikirim ke model:

```dart
context.read<TugasModel>().tambah(judul);
```

Setelah berhasil, halaman ditutup:

```dart
Navigator.pop(context);
```

---

# 10. Perkembangan Latihan 1–4

## Latihan 1 — Validasi

Pada latihan ini, input judul menggunakan `Form` yang dilengkapi validator.

```dart
validator: (v) {
  if (v == null || v.trim().length < 3) {
    return 'Judul minimal 3 karakter';
  }
  return null;
}
```

Dengan validasi tersebut, judul yang kurang dari tiga karakter tidak bisa disimpan.

## Latihan 2 — Hapus Tugas Selesai

Ditambahkan fungsi:

```dart
void hapusSelesai() {
  _items.removeWhere((t) => t.selesai);
  notifyListeners();
}
```

Method ini digunakan untuk menghapus semua tugas yang sudah berstatus selesai.

## Latihan 3 — SnackBar

Setelah tugas berhasil ditambahkan, aplikasi menampilkan informasi menggunakan:

```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('Tugas ditambahkan'),
  ),
);
```

## Latihan 4 — Empty State

Jika belum ada tugas, ditampilkan:

```dart
const Center(
  child: Text('Belum ada tugas'),
)
```

Dengan adanya kondisi ini, pengguna mendapat informasi ketika daftar tugas masih kosong.

---

# 11. Pengembangan Menjadi Daftar Belanja

Setelah aplikasi Daftar Tugas selesai, konsep yang sudah dipelajari kemudian diterapkan pada **Daftar Belanja**.

Struktur data barang:

```dart
class Barang {
  String nama;
  int jumlah;
  String kategori;
  bool sudahDibeli;

  Barang(
    this.nama,
    this.jumlah,
    this.kategori, {
      this.sudahDibeli = false,
    });
}
```

Satu barang memiliki empat informasi:

- nama;
- jumlah;
- kategori;
- status sudah dibeli.

---

# 12. BelanjaModel

Pengelolaan state pada aplikasi Daftar Belanja dilakukan melalui:

```dart
class BelanjaModel extends ChangeNotifier {
  final List<Barang> _items = [];
}
```

Data yang dapat diakses dari model disediakan melalui:

```dart
List<Barang> get items => List.unmodifiable(_items);
```

Untuk mengetahui jumlah barang yang belum dibeli, digunakan perhitungan berikut:

```dart
int get jumlahBelumDibeli =>
    _items.where((barang) => !barang.sudahDibeli).length;
```

Nilai tersebut ditampilkan pada AppBar:

```dart
title: Text(
  'Belum Dibeli (${model.jumlahBelumDibeli})',
),
```

Artinya, saat status checkbox berubah, jumlah barang yang belum dibeli pada AppBar juga akan ikut diperbarui.

---

# 13. Form Tambah Barang

Pada halaman tambah barang terdapat tiga data utama yang perlu diisi:

1. nama barang;
2. jumlah;
3. kategori.

Controller yang digunakan:

```dart
final _nama = TextEditingController();
final _jumlah = TextEditingController();
```

Kategori disimpan sebagai:

```dart
String? _kategori;
```

### Validasi Nama

```dart
if (v == null || v.trim().isEmpty) {
  return 'Nama barang wajib diisi';
}
```

Nama barang tidak boleh kosong.

### Validasi Jumlah

```dart
final jumlah = int.tryParse(v);

if (jumlah == null || jumlah <= 0) {
  return 'Jumlah harus angka lebih dari 0';
}
```

Nilai jumlah harus berupa angka dan lebih besar dari 0.

`int.tryParse()` digunakan untuk mengecek apakah input yang diberikan dapat diubah menjadi nilai integer.

### Validasi Kategori

Kategori wajib dipilih:

```dart
if (v == null) {
  return 'Kategori wajib dipilih';
}
```

Pilihan kategori:

```text
Makanan
Minuman
Lainnya
```

---

# 14. Proses Penyimpanan

Jika semua input sudah lolos validasi, data kemudian dikirim ke model:

```dart
context.read<BelanjaModel>().tambah(
  _nama.text.trim(),
  int.parse(_jumlah.text),
  _kategori!,
);
```

Setelah data berhasil disimpan, pengguna kembali ke halaman daftar dengan:

```dart
Navigator.pop(context);
```

Alur programnya:

```text
Isi form
   ↓
Klik Simpan
   ↓
Validasi
   ↓
Data valid?
 ┌─┴─┐
Tidak Ya
 ↓    ↓
Error  Tambah ke model
          ↓
   notifyListeners()
          ↓
     UI diperbarui
          ↓
   Kembali ke daftar
```

---

# 15. Tampilan Daftar Belanja

Daftar barang ditampilkan menggunakan `ListView.builder`.

Nama barang:

```dart
title: Text(barang.nama)
```

Informasi jumlah dan kategori:

```dart
subtitle: Text(
  'Jumlah: ${barang.jumlah} | Kategori: ${barang.kategori}',
)
```

Status pembelian menggunakan checkbox:

```dart
Checkbox(
  value: barang.sudahDibeli,
  onChanged: (_) {
    context.read<BelanjaModel>().toggle(index);
  },
)
```

Jika barang sudah dibeli, nama barang akan ditampilkan dengan garis coret.

Pengguna juga dapat menghapus barang melalui tombol delete.

---

# 16. Alur State Management

Secara umum, proses pengelolaan state pada aplikasi dapat dilihat melalui alur berikut:

```text
             Form Input
                 ↓
          Validasi Data
                 ↓
        context.read<Model>
                 ↓
             Model
                 ↓
       notifyListeners()
                 ↓
        context.watch()
                 ↓
          Tampilan UI
```

Model digunakan untuk mengelola data, sementara halaman menangani input pengguna dan menampilkan data tersebut.

---

# 17. setState dan Provider

Pada tahap awal, `setState()` masih cocok digunakan karena state hanya dibutuhkan pada satu halaman.

Contohnya:

```dart
setState(() {
  _jurusan = v;
});
```

Saat aplikasi mulai memiliki beberapa halaman yang membutuhkan data yang sama, `ChangeNotifier` dan `Provider` digunakan untuk membantu mengelola state tersebut.

| Kebutuhan | Teknologi |
|---|---|
| State sederhana | `setState()` |
| State terpusat | `ChangeNotifier` |
| Membagikan model | `Provider` |
| Mengikuti perubahan | `context.watch()` |
| Menjalankan method | `context.read()` |

Menurut saya, perbedaan ini penting karena membantu memahami kapan `setState()` sudah cukup dan kapan state perlu dikelola dengan cara yang lebih terpusat.

---

# 18. Beberapa Catatan Teknis

### `List.unmodifiable()`

```dart
List<Barang> get items => List.unmodifiable(_items);
```

List yang diberikan kepada widget tidak bisa diubah langsung. Jika ingin mengubah data, prosesnya dilakukan melalui method yang ada di model.

### `notifyListeners()`

Method ini dijalankan setiap kali ada perubahan data di dalam model.

```dart
_items.add(...);
notifyListeners();
```

### `int.tryParse()`

Fungsi ini digunakan untuk mengubah input berupa string menjadi angka dengan lebih aman.

```dart
final jumlah = int.tryParse(v);
```

Jika input tidak dapat dibaca sebagai angka, hasil yang diberikan adalah `null`.

### `dispose()`

Controller dibersihkan saat halaman sudah selesai digunakan:

```dart
@override
void dispose() {
  _nama.dispose();
  _jumlah.dispose();
  super.dispose();
}
```

---

# 19. Pengujian

Beberapa kondisi yang perlu diuji:

| Kondisi | Hasil |
|---|---|
| Nama kosong | Validasi muncul |
| Jumlah kosong | Validasi muncul |
| Jumlah berupa huruf | Ditolak |
| Jumlah `0` | Ditolak |
| Jumlah negatif | Ditolak |
| Kategori tidak dipilih | Validasi muncul |
| Semua input benar | Barang ditambahkan |
| Checkbox dicentang | Status menjadi sudah dibeli |
| Checkbox dilepas | Status kembali belum dibeli |
| Tombol hapus ditekan | Barang dihapus |
| Barang bertambah | Jumlah pada AppBar diperbarui |

Pengujian dilakukan untuk memastikan proses input, pengelolaan data, dan tampilan aplikasi berjalan dengan baik.

---

# 20. Struktur Konsep yang Dipelajari

```text
INPUT
 │
 ├── TextField
 ├── TextFormField
 ├── Dropdown
 └── Checkbox
 │
 ↓
VALIDASI
 │
 └── Form + Validator
 │
 ↓
STATE
 │
 ├── setState
 ├── ChangeNotifier
 └── Provider
 │
 ↓
UI
 │
 ├── Text
 ├── ListView
 ├── SnackBar
 └── AppBar
```

Dari praktikum ini saya memahami bahwa input pengguna tidak langsung ditampilkan begitu saja. Data perlu divalidasi dan dikelola melalui state sebelum ditampilkan pada UI.

---

# 21. Hasil yang Dicapai

Setelah praktikum selesai, beberapa fitur yang berhasil saya buat adalah:

- input menggunakan `TextField`;
- form menggunakan `TextFormField`;
- validasi input;
- dropdown kategori;
- checkbox;
- state menggunakan `setState`;
- state menggunakan `ChangeNotifier`;
- Provider sebagai penghubung state;
- tambah data;
- ubah status data;
- hapus data;
- navigasi antar halaman;
- SnackBar;
- empty state;
- aplikasi Daftar Tugas;
- aplikasi Daftar Belanja.

---

# 22. Kesimpulan

Praktikum pertemuan ketiga membantu saya memahami cara mengolah input pengguna di dalam aplikasi Flutter.

Awalnya saya menggunakan `TextField` dan `setState()` untuk memahami dasar pengelolaan state. Setelah itu, saya menggunakan `Form` dan validator agar data yang dimasukkan dapat diperiksa sebelum diproses.

Pada bagian state management, `ChangeNotifier` dan `Provider` membantu memisahkan pengelolaan data dari tampilan. Konsep ini saya terapkan pada aplikasi Daftar Tugas dan kemudian dikembangkan menjadi Daftar Belanja.

Bagian yang paling saya pahami dari praktikum ini adalah alur kerja berikut:

```text
Input pengguna
      ↓
Validasi
      ↓
State
      ↓
Perubahan data
      ↓
notifyListeners()
      ↓
UI diperbarui
```

Dengan memahami alur tersebut, saya jadi lebih mengerti alasan penggunaan state management, bukan hanya mengikuti penulisan sintaksnya.

---

## Checklist Praktikum

- [x] TextField
- [x] TextEditingController
- [x] Form
- [x] TextFormField
- [x] Validator
- [x] DropdownButtonFormField
- [x] Checkbox
- [x] setState
- [x] ChangeNotifier
- [x] Provider
- [x] context.watch
- [x] context.read
- [x] Navigator
- [x] Daftar Tugas
- [x] Latihan 1–4
- [x] Daftar Belanja
- [x] Validasi nama
- [x] Validasi jumlah
- [x] Validasi kategori
- [x] Fitur tambah
- [x] Fitur toggle
- [x] Fitur hapus
- [x] Perhitungan jumlah barang belum dibeli
