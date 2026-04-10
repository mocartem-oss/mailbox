import 'package:flutter/material.dart';
// import 'screen_2.dart';
import 'screen_3.dart';


class EmailModel {
  final String sender;
  final String subject;
  final String preview;
  final String time;
  final bool isRead;

  EmailModel({
    required this.sender,
    required this.subject,
    required this.preview,
    required this.time,
    this.isRead = false,
  });
}

//данные
final List<EmailModel> allEmails = [
  EmailModel(sender: 'GitLab', subject: 'Sign-in from new location', preview: 'Someone signed in to your account...', time: '10:14', isRead: false),
  EmailModel(sender: 'App Store', subject: 'Build issues found', preview: 'We noticed issues with your upload...', time: '00:22', isRead: false),
  EmailModel(sender: 'LinkedIn', subject: 'Security alert', preview: 'New login detected from Netherlands...', time: '9 апр.', isRead: true),
  EmailModel(sender: 'GitHub', subject: 'Repository starred', preview: 'User123 starred your repository...', time: '8 апр.', isRead: true),
  EmailModel(sender: 'Spotify', subject: 'Your weekly mixtape', preview: 'New music based on your taste...', time: '7 апр.', isRead: true),
  EmailModel(sender: 'Netflix', subject: 'New arrival', preview: 'The new season is now available...', time: '5 апр.', isRead: true),
  EmailModel(sender: 'Twitter', subject: 'New follower', preview: 'Someone started following you...', time: '1 апр.', isRead: true),
];

//список и поиск
class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    //фильтрация списка
    final filteredEmails = allEmails.where((email) {
      return email.sender.toLowerCase().contains(searchQuery.toLowerCase()) ||
          email.subject.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 252, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 252, 252),
        elevation: 0,
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 252, 252),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onChanged: (val) {
              setState(() {
                searchQuery = val;
              });
            },
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              hintText: 'Поиск в почте',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredEmails.length,
        itemBuilder: (context, index) {
          final email = filteredEmails[index];
          return ListTile(
            // onTap: () {
            //   // Переход на Экран 2
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => Screen2(email: email)),
            //   );
            // },
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text(email.sender[0], style: const TextStyle(color: Colors.white)),
            ),
            title: Row(
              children: [
                Text(
                  email.sender,
                  style: TextStyle(
                    fontWeight: email.isRead ? FontWeight.normal : FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Text(email.time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  email.subject,
                  style: const TextStyle(color: Colors.grey, overflow: TextOverflow.ellipsis),
                ),
                Text(
                  email.preview,
                  style: const TextStyle(color: Colors.grey, fontSize: 12, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 132, 132, 128),
        child: const Icon(Icons.edit, color: Colors.white),
        onPressed: () {
          //переход на Экран 3
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Screen3()),
          );
        },
      ),
    );
  }
}