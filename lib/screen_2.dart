import 'package:flutter/material.dart';

// --- ВИДЖЕТ БОКОВОГО МЕНЮ (DRAWER) ---
class GmailDrawer extends StatelessWidget {
  const GmailDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF2D241E),
      child: Column(
        children: [
          // Header с Gmail
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Gmail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          
          const Divider(color: Color(0xFF3D342E), height: 1),
          
          // Список пунктов меню
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Несортированные
                _buildMenuItem(
                  icon: Icons.inbox,
                  title: 'Несортированные',
                  badge: '99+',
                  badgeColor: const Color(0xFF6B4E3D),
                ),
                
                // Промоакции
                _buildMenuItem(
                  icon: Icons.label_outlined,
                  title: 'Промоакции',
                  badge: '44 нов.',
                  badgeColor: Colors.green,
                ),
                
                // Соцсети
                _buildMenuItem(
                  icon: Icons.people_outline,
                  title: 'Соцсети',
                  badge: '5 нов.',
                  badgeColor: Colors.blue,
                ),
                
                // Оповещения
                _buildMenuItem(
                  icon: Icons.info_outline,
                  title: 'Оповещения',
                  badge: '75 нов.',
                  badgeColor: Colors.orange,
                ),
                
                const SizedBox(height: 8),
                
                // Разделитель "Все ярлыки"
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 16, 8),
                  child: Text(
                    'Все ярлыки',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                
                // Помеченные
                _buildMenuItem(
                  icon: Icons.star_border,
                  title: 'Помеченные',
                ),
                
                // Отложенные
                _buildMenuItem(
                  icon: Icons.schedule,
                  title: 'Отложенные',
                ),
                
                // Важные
                _buildMenuItem(
                  icon: Icons.label_important_outline,
                  title: 'Важные',
                  badge: '84',
                ),
                
                // Покупки
                _buildMenuItem(
                  icon: Icons.shopping_bag_outlined,
                  title: 'Покупки',
                  badge: '58',
                ),
                
                // Отправленные
                _buildMenuItem(
                  icon: Icons.send_outlined,
                  title: 'Отправленные',
                ),
                
                // Запланированные
                _buildMenuItem(
                  icon: Icons.schedule_send,
                  title: 'Запланированные',
                ),
                
                // Исходящие
                _buildMenuItem(
                  icon: Icons.outbox,
                  title: 'Исходящие',
                ),
                
                // Черновики
                _buildMenuItem(
                  icon: Icons.drafts_outlined,
                  title: 'Черновики',
                  badge: '5',
                ),
                
                // Вся почта
                _buildMenuItem(
                  icon: Icons.email_outlined,
                  title: 'Вся почта',
                  badge: '99+',
                ),
                
                // Спам
                _buildMenuItem(
                  icon: Icons.report_outlined,
                  title: 'Спам',
                  badge: '718',
                ),
                
                // Корзина
                _buildMenuItem(
                  icon: Icons.delete_outline,
                  title: 'Корзина',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? badge,
    Color? badgeColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey[400],
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey[300],
          fontSize: 15,
        ),
      ),
      trailing: badge != null
          ? _buildBadge(badge, badgeColor ?? const Color(0xFF6B4E3D))
          : null,
      onTap: () {
        Navigator.pop(context);
        // Здесь можно добавить навигацию
      },
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
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
