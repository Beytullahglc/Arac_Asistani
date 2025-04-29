import 'package:flutter/material.dart';
import '../service/auth.dart';

class SifreDegistirSayfa extends StatefulWidget {
  const SifreDegistirSayfa({super.key});

  @override
  State<SifreDegistirSayfa> createState() => _SifreDegistirSayfaState();
}

class _SifreDegistirSayfaState extends State<SifreDegistirSayfa> {
  final TextEditingController mevcutSifreController = TextEditingController();
  final TextEditingController yeniSifreController = TextEditingController();
  final TextEditingController yeniSifreTekrarController = TextEditingController();

  @override
  void dispose() {
    mevcutSifreController.dispose();
    yeniSifreController.dispose();
    yeniSifreTekrarController.dispose();
    super.dispose();
  }

  Future<void> sifreyiGuncelle() async {
    final mevcutSifre = mevcutSifreController.text.trim();
    final yeniSifre = yeniSifreController.text.trim();
    final yeniSifreTekrar = yeniSifreTekrarController.text.trim();

    if (mevcutSifre.isEmpty || yeniSifre.isEmpty || yeniSifreTekrar.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen tüm alanları doldurun")),
      );
      return;
    }

    if (yeniSifre != yeniSifreTekrar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Yeni şifreler uyuşmuyor")),
      );
      return;
    }

    final sonuc = await AuthService().changePassword(
      currentPassword: mevcutSifre,
      newPassword: yeniSifre,
    );


    if (sonuc == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Şifre başarıyla güncellendi")),
      );
      Navigator.pop(context); // başarılıysa geri dön
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(sonuc)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Şifre Değiştir"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            TextField(
              controller: mevcutSifreController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Mevcut Şifre",
                border: inputBorder,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                controller: yeniSifreController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Yeni Şifre",
                  border: inputBorder,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: yeniSifreTekrarController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Yeni Şifre (Tekrar)",
                border: inputBorder,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: sifreyiGuncelle,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Şifreyi Güncelle",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
