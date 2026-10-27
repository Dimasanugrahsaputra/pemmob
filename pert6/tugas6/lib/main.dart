
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Pengaturan tema
final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);
final seedColor = ValueNotifier<Color>(Colors.indigo);

const pilihanWarna = [
  Colors.indigo,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
];

// Model data makanan
class Makanan {
  final String nama;
  final String harga;
  final String deskripsi;
  final IconData ikon;

  const Makanan(
      this.nama,
      this.harga,
      this.deskripsi,
      this.ikon,
      );
}

// Data katalog makanan
const daftarMakanan = [
  Makanan(
    'Nasi Goreng',
    'Rp15.000',
    'Nasi goreng dengan bumbu khas dan telur.',
    Icons.rice_bowl,
  ),
  Makanan(
    'Mie Ayam',
    'Rp12.000',
    'Mie dengan potongan ayam dan sayuran.',
    Icons.ramen_dining,
  ),
  Makanan(
    'Ayam Bakar',
    'Rp20.000',
    'Ayam bakar berbumbu dengan rasa gurih.',
    Icons.restaurant,
  ),
  Makanan(
    'Sate Ayam',
    'Rp18.000',
    'Sate ayam yang disajikan dengan bumbu kacang.',
    Icons.kebab_dining,
  ),
];

// Membuat tema aplikasi
ThemeData buatTema(Color warna, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: warna,
    brightness: brightness,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
  );
}

// Menyimpan pengaturan tema
Future<void> simpanModeGelap(bool aktif) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('mode_gelap', aktif);
}

Future<void> simpanWarnaTema(Color warna) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('warna_tema', warna.toARGB32());
}

// Membaca pengaturan tema
Future<void> muatPengaturanTema() async {
  final prefs = await SharedPreferences.getInstance();

  final modeGelap = prefs.getBool('mode_gelap') ?? false;
  final warnaTersimpan = prefs.getInt('warna_tema');

  themeMode.value =
  modeGelap ? ThemeMode.dark : ThemeMode.light;

  if (warnaTersimpan != null) {
    for (final warna in pilihanWarna) {
      if (warna.toARGB32() == warnaTersimpan) {
        seedColor.value = warna;
        break;
      }
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await muatPengaturanTema();
  runApp(const MyApp());
}

// Aplikasi utama
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([themeMode, seedColor]),
      builder: (context, _) {
        return MaterialApp(
          title: 'Katalog Makanan',
          debugShowCheckedModeBanner: false,
          theme: buatTema(seedColor.value, Brightness.light),
          darkTheme: buatTema(seedColor.value, Brightness.dark),
          themeMode: themeMode.value,
          initialRoute: '/',
          routes: {
            '/': (_) => const ShellPage(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/detail') {
              final makanan = settings.arguments as Makanan;

              return PageRouteBuilder(
                settings: settings,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return DetailPage(makanan: makanan);
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            }

            return null;
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              builder: (_) => const Halaman404(),
            );
          },
        );
      },
    );
  }
}

// Navigasi bawah tiga tab
class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0;

  static const _judul = [
    'Beranda',
    'Animasi',
    'Pengaturan',
  ];

  static const _halaman = [
    BerandaTab(),
    AnimasiTab(),
    PengaturanTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_index]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: warna.primaryContainer,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Katalog Makanan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Beranda'),
              onTap: () {
                setState(() => _index = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.animation_outlined),
              title: const Text('Animasi'),
              onTap: () {
                setState(() => _index = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Pengaturan'),
              onTap: () {
                setState(() => _index = 2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _index,
        children: _halaman,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) {
          setState(() => _index = i);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.animation_outlined),
            selectedIcon: Icon(Icons.animation),
            label: 'Animasi',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}

// Tab beranda
class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Selamat Datang!',
          style: tema.textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Temukan makanan favoritmu di sini.',
          style: tema.textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        for (final makanan in daftarMakanan)
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Hero(
                tag: 'ikon-${makanan.nama}',
                child: CircleAvatar(
                  backgroundColor: warna.primaryContainer,
                  child: Icon(
                    makanan.ikon,
                    color: warna.onPrimaryContainer,
                  ),
                ),
              ),
              title: Text(
                makanan.nama,
                style: tema.textTheme.titleMedium,
              ),
              subtitle: Text(makanan.harga),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: makanan,
                );
              },
            ),
          ),
      ],
    );
  }
}

// Tab animasi
class AnimasiTab extends StatefulWidget {
  const AnimasiTab({super.key});

  @override
  State<AnimasiTab> createState() => _AnimasiTabState();
}

class _AnimasiTabState extends State<AnimasiTab>
    with SingleTickerProviderStateMixin {
  bool _besar = false;
  bool _terlihat = true;
  int _hitung = 0;

  late final AnimationController _putar;

  @override
  void initState() {
    super.initState();

    _putar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _putar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          '1. AnimatedContainer',
          style: tema.textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: _besar ? 200 : 100,
            height: 100,
            decoration: BoxDecoration(
              color: _besar ? warna.primary : warna.tertiary,
              borderRadius: BorderRadius.circular(
                _besar ? 50 : 8,
              ),
            ),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              setState(() => _besar = !_besar);
            },
            child: const Text('Ubah bentuk'),
          ),
        ),
        const Divider(),

        Text(
          '2. AnimatedSwitcher',
          style: tema.textTheme.titleMedium,
        ),
        Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: Text(
              '$_hitung',
              key: ValueKey(_hitung),
              style: tema.textTheme.displayMedium,
            ),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              setState(() => _hitung++);
            },
            child: const Text('Tambah angka'),
          ),
        ),
        const Divider(),

        Text(
          '3. AnimationController',
          style: tema.textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Center(
          child: RotationTransition(
            turns: _putar,
            child: Icon(
              Icons.restaurant,
              size: 64,
              color: warna.primary,
            ),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              if (_putar.isAnimating) {
                _putar.stop();
              } else {
                _putar.repeat();
              }
              setState(() {});
            },
            child: Text(
              _putar.isAnimating ? 'Berhenti' : 'Putar',
            ),
          ),
        ),
        const Divider(),

        Text(
          '4. AnimatedOpacity',
          style: tema.textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        AnimatedOpacity(
          opacity: _terlihat ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Card(
            child: ListTile(
              leading: Icon(
                Icons.fastfood,
                color: warna.primary,
                size: 36,
              ),
              title: const Text('Makanan Favorit'),
              subtitle: const Text(
                'Nikmati makanan kesukaanmu.',
              ),
            ),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              setState(() => _terlihat = !_terlihat);
            },
            child: Text(
              _terlihat ? 'Sembunyikan kartu' : 'Tampilkan kartu',
            ),
          ),
        ),
      ],
    );
  }
}

// Halaman detail makanan
class DetailPage extends StatelessWidget {
  final Makanan makanan;

  const DetailPage({
    super.key,
    required this.makanan,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(makanan.nama),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'ikon-${makanan.nama}',
                child: CircleAvatar(
                  radius: 64,
                  backgroundColor: warna.primaryContainer,
                  child: Icon(
                    makanan.ikon,
                    size: 64,
                    color: warna.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                makanan.nama,
                style: tema.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                makanan.harga,
                style: tema.textTheme.titleLarge?.copyWith(
                  color: warna.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                makanan.deskripsi,
                textAlign: TextAlign.center,
                style: tema.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tab pengaturan
class PengaturanTab extends StatelessWidget {
  const PengaturanTab({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return ListenableBuilder(
      listenable: Listenable.merge([themeMode, seedColor]),
      builder: (context, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Pengaturan Tampilan',
              style: tema.textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Mode gelap'),
              subtitle: const Text(
                'Mengubah tampilan terang atau gelap.',
              ),
              value: themeMode.value == ThemeMode.dark,
              onChanged: (aktif) {
                themeMode.value =
                aktif ? ThemeMode.dark : ThemeMode.light;
                simpanModeGelap(aktif);
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Warna tema',
              style: tema.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final warna in pilihanWarna)
                  GestureDetector(
                    onTap: () {
                      seedColor.value = warna;
                      simpanWarnaTema(warna);
                    },
                    child: CircleAvatar(
                      backgroundColor: warna,
                      child: seedColor.value == warna
                          ? const Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Pilihan tema akan tersimpan saat aplikasi ditutup.',
              style: tema.textTheme.bodyMedium,
            ),
          ],
        );
      },
    );
  }
}

// Halaman 404
class Halaman404 extends StatelessWidget {
  const Halaman404({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Tidak Ditemukan'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: warna.primary,
            ),
            const SizedBox(height: 16),
            Text(
              '404 - Halaman tidak ditemukan',
              style: tema.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                      (route) => false,
                );
              },
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}
