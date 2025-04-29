import 'package:flutter/material.dart';

class YardimSayfa extends StatelessWidget {
  const YardimSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    final sorular = [
      {
        "soru": "Uygulama ne işe yarar?",
        "cevap":
        "Araç Asistanı uygulaması, araç sahiplerine bakım, takip ve asistan hizmeti sunar. Geçmiş konuşmaları kaydeder ve size özel çözümler önerir."
      },
      {
        "soru": "Nasıl üye olabilirim?",
        "cevap":
        "Ayarlar sayfasına giderek 'Üye Ol' seçeneğine tıklayabilir ve kayıt formunu doldurarak kolayca üye olabilirsiniz."
      },
      {
        "soru": "Şifremi nasıl değiştirebilirim?",
        "cevap":
        "Şifrenizi ayarlar sayfasından şifre değiştir seçeneğine tıklayabilir ve formu doldurarak kolayca şifrenizi değiştirebilirsiniz"
      },
      {
        "soru": "Verilerim güvende mi?",
        "cevap":
        "Evet, verileriniz Firebase tarafından güvenli bir şekilde saklanır ve sadece sizin erişebileceğiniz şekilde korunur."
      },
      {
        "soru": "Konuşmaları nasıl görüntüleyebilirim?",
        "cevap":
        "Geçmiş sayfasına giderek önceki konuşmalarınızı görebilir ve isterseniz herhangi birini seçerek devam edebilirsiniz."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Yardım"),
      ),
      body: ListView.builder(
        itemCount: sorular.length,
        itemBuilder: (context, index) {
          final soru = sorular[index];
          return ExpansionTile(
            title: Text(soru["soru"]!,style: TextStyle(fontSize: 20),),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(soru["cevap"]!,style: TextStyle(fontSize: 18),),
              ),
            ],
          );
        },
      ),
    );
  }
}
