import 'package:arac_asistani/main.dart';
import 'package:arac_asistani/service/auth.dart';
import 'package:arac_asistani/views/arizaTespitSayfa.dart';
import 'package:arac_asistani/views/ayarlarSayfa.dart';
import 'package:arac_asistani/views/gecmisSayfa.dart';
import 'package:arac_asistani/views/yard%C4%B1mSayfa.dart';
import 'package:flutter/material.dart';

class Aracbilgisisayfa extends StatefulWidget {
  const Aracbilgisisayfa({super.key});

  @override
  State<Aracbilgisisayfa> createState() => _AracbilgisisayfaState();
}

class _AracbilgisisayfaState extends State<Aracbilgisisayfa> {
    final TextEditingController _controller = TextEditingController();

    List<Map<String, String>> chat = [
      {'role': 'assistant', 'text': 'Merhaba, size nasıl yardımcı olabilirim?'},
    ];

    void _sendMessage() {
      if (_controller.text.trim().isEmpty) return;

      setState(() {
        chat.add({'role': 'user', 'text': _controller.text.trim()});
        chat.add({
          'role': 'assistant',
          'text': 'Bunu LLM modeli yanıtlayacak: ${_controller.text.trim()}'
        });
        _controller.clear();
      });
    }

    @override
    Widget build(BuildContext context) {

      final user = AuthService().currentUser;
      final displayName = user?.displayName ?? '';

      return Scaffold(
        appBar: AppBar(
          title: const Text('Araç Bilgisi'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFFE0E0E0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      '$displayName',
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage(title: 'Araç Asistanı')));
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
                  Navigator.pop(context);
                },
              ),
               DrawerItem(
                icon: Icons.history,
                title: 'Geçmiş',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>   GecmisSayfa()),
                  );
                },
              ),
               DrawerItem(
                icon: Icons.settings,
                title: 'Ayarlar',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AyarlarSayfa()));
                },
              ),
              DrawerItem(
                icon: Icons.help,
                title: 'Yardım',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> YardimSayfa()));
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: chat.length,
                itemBuilder: (context, index) {
                  final message = chat[index];
                  final isUser = message['role'] == 'user';

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message['text']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Colors.grey[100],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Bir arıza sorusu yazın...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[300],
                      foregroundColor: Colors.black87,
                    ),
                    child: const Text('Gönder'),
                  ),
                ],
              ),
            ),
          ],
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
