import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFE0E0E0),
              ),
              child: Text(
                'Menü',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                ),
              ),
            ),
            const DrawerItem(icon: Icons.home, title: 'Ana Sayfa'),
            const DrawerItem(icon: Icons.build, title: 'Arıza Tespiti'),
            const DrawerItem(icon: Icons.directions_car, title: 'Araç Bilgisi'),
            const DrawerItem(icon: Icons.history, title: 'Geçmiş'),
            const DrawerItem(icon: Icons.settings, title: 'Ayarlar'),
            const DrawerItem(icon: Icons.help, title: 'Yardım'),
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
            onTap: () {},
          ),
          buildFeatureCard(
            icon: Icons.directions_car,
            label: 'Araç Bilgisi',
            onTap: () {},
          ),
          buildFeatureCard(
            icon: Icons.history,
            label: 'Geçmiş',
            onTap: () {},
          ),
          buildFeatureCard(
            icon: Icons.settings,
            label: 'Ayarlar',
            onTap: () {},
          ),
          buildFeatureCard(
            icon: Icons.help,
            label: 'Yardım',
            onTap: () {},
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
                color: Colors.black54, // Daha açık siyah
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54, // Aynı renk, daha açık siyah
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

  const DrawerItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54), // Aynı renk, daha açık siyah
      title: Text(
        title,
        style: const TextStyle(color: Colors.black54), // Aynı renk, daha açık siyah
      ),
      onTap: () {
        Navigator.pop(context);
        // Buraya ilgili sayfa navigasyonu eklenecek
      },
    );
  }
}
