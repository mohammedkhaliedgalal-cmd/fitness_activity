import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      'icon': Icons.fitness_center,
      'title': 'Workout Reminder',
      'message': 'It is time for your daily workout.',
      'time': '10 min ago',
      'unread': true,
    },
    {
      'icon': Icons.favorite_outline,
      'title': 'New Activity',
      'message': 'Your friend liked your workout.',
      'time': '1 hour ago',
      'unread': true,
    },
    {
      'icon': Icons.emoji_events_outlined,
      'title': 'New Achievement',
      'message': 'You completed a new fitness goal.',
      'time': '3 hours ago',
      'unread': false,
    },
    {
      'icon': Icons.people_outline,
      'title': 'New Friend',
      'message': 'Someone started following you.',
      'time': 'Yesterday',
      'unread': false,
    },
  ];

  void openNotification(int index) {
    setState(() {
      notifications[index]['unread'] = false;
    });

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            notifications[index]['title'],
          ),
          content: Text(
            notifications[index]['message'],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void markAllAsRead() {
    setState(() {
      for (final notification in notifications) {
        notification['unread'] = false;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Notifications Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Notifications.jpg',
                  width: 220,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 220,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.notifications,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Stay updated with your workouts and fitness activities.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            // Notifications List
            for (int i = 0; i < notifications.length; i++) ...[
              _notificationItem(
                index: i,
                icon: notifications[i]['icon'] as IconData,
                title: notifications[i]['title'] as String,
                message: notifications[i]['message'] as String,
                time: notifications[i]['time'] as String,
                unread: notifications[i]['unread'] as bool,
              ),
              if (i != notifications.length - 1)
                const SizedBox(height: 12),
            ],

            const SizedBox(height: 25),

            // Mark All As Read
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: markAllAsRead,
                child: const Text(
                  'MARK ALL AS READ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _notificationItem({
    required int index,
    required IconData icon,
    required String title,
    required String message,
    required String time,
    required bool unread,
  }) {
    return InkWell(
      onTap: () {
        openNotification(index);
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F1F3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 25,
                color: Colors.black,
              ),
            ),

            const SizedBox(width: 13),

            // Notification Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          unread ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            // Unread Indicator
            if (unread)
              Container(
                width: 9,
                height: 9,
                margin: const EdgeInsets.only(top: 5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}