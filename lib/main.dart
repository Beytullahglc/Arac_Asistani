import 'package:arac_asistani/views/aracBilgisiSayfa.dart';
import 'package:arac_asistani/views/arizaTespitSayfa.dart';
import 'package:arac_asistani/views/ayarlarSayfa.dart';
import 'package:arac_asistani/views/gecmisSayfa.dart';
import 'package:arac_asistani/views/yardımSayfa.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth importu
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Araç Asistanı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F5F5),
          foregroundColor: Colors.black,
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFFF5F5F5),
        ),
      ),
      home: const MyHomePage(
        title: 'Araç Asistanı',
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Firebase Authentication'dan mevcut kullanıcıyı al
    User? currentUser = FirebaseAuth.instance.currentUser;
    String adSoyad = currentUser?.displayName ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kullanıcının ad ve soyadını göster
                  Text(
                    'Hoşgeldiniz,',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                   Text(
                    '$adSoyad',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            DrawerItem(
              icon: Icons.home,
              title: 'Ana Sayfa',
              onTap: () {
                Navigator.pop(context); // Menü kapansın
              },
            ),
            DrawerItem(
              icon: Icons.build,
              title: 'Arıza Tespiti',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ArizaTespitSayfa()),
                );
              },
            ),
            DrawerItem(
              icon: Icons.directions_car,
              title: 'Araç Bilgisi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Aracbilgisisayfa()),
                );
              },
            ),
            DrawerItem(
              icon: Icons.history,
              title: 'Geçmiş',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GecmisSayfa()),
                );
              },
            ),
            DrawerItem(
              icon: Icons.settings,
              title: 'Ayarlar',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AyarlarSayfa()));
              },
            ),
            DrawerItem(
              icon: Icons.help,
              title: 'Yardım',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const YardimSayfa()));
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          buildFeatureCard(
            icon: Icons.build,
            label: 'Arıza Tespiti',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ArizaTespitSayfa()));
            },
          ),
          buildFeatureCard(
            icon: Icons.directions_car,
            label: 'Araç Bilgisi',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Aracbilgisisayfa()));
            },
          ),
          buildFeatureCard(
            icon: Icons.history,
            label: 'Geçmiş',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GecmisSayfa()));
            },
          ),
          buildFeatureCard(
            icon: Icons.settings,
            label: 'Ayarlar',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AyarlarSayfa()));
            },
          ),
          buildFeatureCard(
            icon: Icons.help,
            label: 'Yardım',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const YardimSayfa()));
            },
          ),
        ],
      ),
    );
  }

  Widget buildFeatureCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFFF0F0F0),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.black54,
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black54),
      ),
      onTap: onTap,
    );
  }
}
