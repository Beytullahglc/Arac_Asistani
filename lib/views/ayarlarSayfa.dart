import 'package:arac_asistani/service/auth.dart';
import 'package:arac_asistani/views/sifreDegistirSayfa.dart';
import 'package:arac_asistani/views/uyeOlSayfa.dart';
import 'package:flutter/material.dart';

class AyarlarSayfa extends StatelessWidget {
  const AyarlarSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text(
              "Şifre Değiştir",
              style: TextStyle(fontSize: 20),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SifreDegistirSayfa()));
            },
          ),

          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text(
              "Üye Ol",
              style: TextStyle(fontSize: 20),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UyeOlSayfa()));
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              "Çıkış Yap",
              style: TextStyle(fontSize: 20),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 20),
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Çıkış Yap"),
        content: const Text(
          "Çıkış yapmak istediğinizden emin misiniz?",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              "İptal",
              style: TextStyle(fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop(); // Önce dialogu kapat

              // 1. Firebase'den çıkış yap
              await AuthService().signOut();

              // 2. Giriş sayfasına yönlendir
              Navigator.pushReplacementNamed(context, "/giris");
            },
            child: const Text(
              "Çıkış Yap",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
