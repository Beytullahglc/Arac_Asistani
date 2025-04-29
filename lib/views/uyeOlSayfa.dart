import 'package:flutter/material.dart';
import 'package:arac_asistani/service/auth.dart'; // AuthService importu

class UyeOlSayfa extends StatefulWidget {
  const UyeOlSayfa({super.key});

  @override
  State<UyeOlSayfa> createState() => _UyeOlSayfaState();
}

class _UyeOlSayfaState extends State<UyeOlSayfa> {
  bool isUyeOl = true;

  // TextEditingController'lar
  final TextEditingController adSoyadController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();

  final AuthService _authService = AuthService();

  // Kullanıcı kayıt veya giriş işlemi
  void _submit() async {
    String email = emailController.text.trim();
    String sifre = sifreController.text.trim();
    String adSoyad = adSoyadController.text.trim();

    if (email.isEmpty || sifre.isEmpty || (isUyeOl && adSoyad.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen tüm alanları doldurun')),
      );
      return;
    }

    if (isUyeOl) {
      // Kayıt ol
      final result = await _authService.createUser(email, sifre, adSoyad);
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kayıt başarılı!')),
        );
        Navigator.pop(context); // Başarılıysa geri dön
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kayıt başarısız.')),
        );
      }
    } else {
      // Giriş yap
      final result = await _authService.signIn(email, sifre);
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Giriş başarılı!')),
        );
        Navigator.pop(context); // Başarılıysa geri dön
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Giriş başarısız.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(isUyeOl ? "Üye Ol" : "Giriş Yap"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      isUyeOl ? "Hesap Oluştur" : "Giriş Yap",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 36),

                    if (isUyeOl) ...[
                      TextField(
                        controller: adSoyadController,
                        decoration: InputDecoration(
                          labelText: "Ad Soyad",
                          border: inputBorder,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: inputBorder,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    TextField(
                      controller: sifreController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Şifre",
                        border: inputBorder,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text(
                isUyeOl ? "Kayıt Ol" : "Giriş Yap",
                style: const TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {
                setState(() {
                  isUyeOl = !isUyeOl;
                });
              },
              child: Text(
                isUyeOl
                    ? "Zaten hesabın var mı? Giriş yap"
                    : "Hesabın yok mu? Üye ol",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
