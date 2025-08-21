import 'package:flutter/material.dart';
import 'Debate_Detail _screen.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    await Future.delayed(Duration(seconds: 1));

    final now = DateTime.now();

    setState(() {
      notifications = [
        {
          'user': 'Aman',
          'message': 'Aman replied to your debate',
          'timestamp': now.subtract(Duration(hours: 1)),
          'read': false,
        },
        {
          'user': 'Harsh',
          'message': 'Harsh liked your comment',
          'timestamp': now.subtract(Duration(hours: 3)),
          'read': false,
        },
        {
          'user': 'Riya',
          'message': 'Riya mentioned you in a comment',
          'timestamp': now.subtract(Duration(hours: 6)),
          'read': false,
        },
        {
          'user': 'Rahul',
          'message': 'Rahul tagged you in a debate',
          'timestamp': now.subtract(Duration(days: 1)),
          'read': false,
        },
        {
          'user': 'System',
          'message': 'New debate started in Politics',
          'timestamp': now.subtract(Duration(days: 1, hours: 8)),
          'read': true,
        },
        {
          'user': 'Nikhil',
          'message': 'Nikhil replied to your post',
          'timestamp': now.subtract(Duration(days: 2)),
          'read': true,
        },
        {
          'user': 'Komal',
          'message': 'Your debate got 5 new likes',
          'timestamp': now.subtract(Duration(days: 3)),
          'read': true,
        },
        {
          'user': 'Vikas',
          'message': 'Vikas replied to your argument',
          'timestamp': now.subtract(Duration(days: 5)),
          'read': true,
        },
      ];
    });
  }

  void _markAsRead(int index) {
    setState(() {
      notifications[index]['read'] = true;
    });
  }

  String _formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return '${time.day}/${time.month}/${time.year}';
  }

  Map<String, List<Map<String, dynamic>>> _groupNotifications() {
    final today = DateTime.now();
    final todayGroup = <Map<String, dynamic>>[];
    final earlierGroup = <Map<String, dynamic>>[];

    for (var notif in notifications) {
      final ts = notif['timestamp'] as DateTime;
      if (ts.day == today.day && ts.month == today.month && ts.year == today.year) {
        todayGroup.add(notif);
      } else {
        earlierGroup.add(notif);
      }
    }

    return {
      'Today': todayGroup,
      'Earlier': earlierGroup,
    };
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupNotifications();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView(
        children: [
          ...grouped.entries.expand((entry) {
            final groupTitle = entry.key;
            final groupItems = entry.value;

            return [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Text(
                  groupTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              ...groupItems.asMap().entries.map((item) {
                final indexInAll = notifications.indexOf(item.value);
                final notification = item.value;
                final isRead = notification['read'] as bool;
                final time = _formatTimeAgo(notification['timestamp']);

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(notification['user'][0]),
                  ),
                  title: Text(
                    notification['message'],
                    style: TextStyle(
                      fontWeight: isRead ? FontWeight.normal : FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(time),
                  trailing: isRead
                      ? null
                      : Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 10,
                  ),
                  onTap: () {
                    _markAsRead(indexInAll);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DebateDetailScreen(),
                      ),
                    );
                  },
                );
              }).toList(),
            ];
          }),
        ],
      ),
    );
  }
}
