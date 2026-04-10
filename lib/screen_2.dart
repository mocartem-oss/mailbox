import 'package:flutter/material.dart';

// --- МОДЕЛЬ ДАННЫХ (Письмо) ---
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

// --- МОДЕЛЬ ЭЛЕМЕНТА МЕНЮ ---
class MenuItemModel {
  final IconData icon;
  final String title;
  final String? badge;
  final Color? badgeColor;
  final bool isSectionHeader;

  MenuItemModel({
    required this.icon,
    required this.title,
    this.badge,
    this.badgeColor,
    this.isSectionHeader = false,
  });
}

// --- ДАННЫЕ (Примеры писем) ---
final List<EmailModel> allEmails = [
  EmailModel(sender: 'GitLab', subject: 'Sign-in from new location', preview: 'Someone signed in to your account...', time: '10:14', isRead: false),
  EmailModel(sender: 'App Store', subject: 'Build issues found', preview: 'We noticed issues with your upload...', time: '00:22', isRead: false),
  EmailModel(sender: 'LinkedIn', subject: 'Security alert', preview: 'New login detected from Netherlands...', time: '9 апр.', isRead: true),
  EmailModel(sender: 'GitHub', subject: 'Repository starred', preview: 'User123 starred your repository...', time: '8 апр.', isRead: true),
  EmailModel(sender: 'Spotify', subject: 'Your weekly mixtape', preview: 'New music based on your taste...', time: '7 апр.', isRead: true),
  EmailModel(sender: 'Netflix', subject: 'New arrival', preview: 'The new season is now available...', time: '5 апр.', isRead: true),
  EmailModel(sender: 'Twitter', subject: 'New follower', preview: 'Someone started following you...', time: '1 апр.', isRead: true),
];

// --- ДАННЫЕ МЕНЮ ---
final List<MenuItemModel> menuItems = [
  MenuItemModel(icon: Icons.inbox, title: 'Несортированные', badge: '99+', badgeColor: const Color(0xFF6B4E3D)),
  MenuItemModel(icon: Icons.label_outlined, title: 'Промоакции', badge: '44 нов.', badgeColor: Colors.green),
  MenuItemModel(icon: Icons.people_outline, title: 'Соцсети', badge: '5 нов.', badgeColor: Colors.blue),
  MenuItemModel(icon: Icons.info_outline, title: 'Оповещения', badge: '75 нов.', badgeColor: Colors.orange),
  MenuItemModel(icon: Icons.folder_copy, title: 'Все ярлыки', isSectionHeader: true),
  MenuItemModel(icon: Icons.star_border, title: 'Помеченные'),
  MenuItemModel(icon: Icons.schedule, title: 'Отложенные'),
  MenuItemModel(icon: Icons.label_important_outline, title: 'Важные', badge: '84'),
  MenuItemModel(icon: Icons.shopping_bag_outlined, title: 'Покупки', badge: '58'),
  MenuItemModel(icon: Icons.send_outlined, title: 'Отправленные'),
  MenuItemModel(icon: Icons.schedule_send, title: 'Запланированные'),
  MenuItemModel(icon: Icons.outbox, title: 'Исходящие'),
  MenuItemModel(icon: Icons.drafts_outlined, title: 'Черновики', badge: '5'),
  MenuItemModel(icon: Icons.email_outlined, title: 'Вся почта', badge: '99+'),
  MenuItemModel(icon: Icons.report_outlined, title: 'Спам', badge: '718'),
  MenuItemModel(icon: Icons.delete_outline, title: 'Корзина'),
];

// --- ЭКРАН 1 (Список и Поиск) ---
class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  String searchQuery = '';
  String selectedCategory = 'Несортированные';

  @override
  Widget build(BuildContext context) {
    // Фильтрация списка
    final filteredEmails = allEmails.where((email) {
      return email.sender.toLowerCase().contains(searchQuery.toLowerCase()) ||
          email.subject.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onChanged: (val) {
              setState(() {
                searchQuery = val;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Поиск в почте',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: ListView.builder(
        itemCount: filteredEmails.length,
        itemBuilder: (context, index) {
          final email = filteredEmails[index];
          return ListTile(
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
                    color: Colors.white,
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
            trailing: Icon(
              Icons.star_border,
              color: Colors.grey[700],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8B5E3C),
        child: const Icon(Icons.edit, color: Colors.white),
        onPressed: () {
          // Переход на Экран 3
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Screen3()),
          // );
        },
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF2D241E),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
            color: const Color(0xFF2D241E),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Gmail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          
          const Divider(color: Color(0xFF3D342E), height: 1),
          
          // Menu Items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                
                // Section Header
                if (item.isSectionHeader) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                
                // Regular Menu Item
                final isSelected = selectedCategory == item.title;
                return ListTile(
                  leading: Icon(
                    item.icon,
                    color: isSelected ? const Color(0xFF8B5E3C) : Colors.grey[400],
                    size: 24,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      color: isSelected ? const Color(0xFFD4A574) : Colors.grey[300],
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  trailing: item.badge != null
                      ? _buildBadge(item.badge!, item.badgeColor)
                      : null,
                  onTap: () {
                    setState(() {
                      selectedCategory = item.title;
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color? color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color ?? const Color(0xFF6B4E3D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}