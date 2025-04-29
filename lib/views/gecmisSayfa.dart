import 'package:arac_asistani/views/arizaTespitSayfa.dart';
import 'package:flutter/material.dart';

class GecmisSayfa extends StatelessWidget {
  final List<ChatHistory> chatList = [
    ChatHistory(id: "1", title: "Yağ değişimi ne zaman?", date: "13 Nisan 2025"),
    ChatHistory(id: "2", title: "Lastik basıncı normal mi?", date: "10 Nisan 2025"),
    ChatHistory(id: "3", title: "Motor arızası nedir?", date: "5 Nisan 2025"),
  ];

   GecmisSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geçmiş Konuşmalar"),
      ),
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          var chat = chatList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(chat.title),
              subtitle: Text(chat.date),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArizaTespitSayfa(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ChatHistory {
  final String id;
  final String title;
  final String date;

  ChatHistory({required this.id, required this.title, required this.date});
}
