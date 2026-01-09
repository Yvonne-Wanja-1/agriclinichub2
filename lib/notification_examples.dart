import 'package:flutter/material.dart';
import 'core/services/notification_service.dart';

/// Example usage of the notification system
/// This file demonstrates common notification operations

class NotificationExamples {
  /// Example 1: Show a simple local notification
  static Future<void> showSimpleNotification() async {
    await NotificationService.showNotification(
      title: 'Crop Alert',
      body: 'Check your maize field for pests',
    );
  }

  /// Example 2: Show disease detection alert
  static Future<void> showDiseaseDetectionAlert() async {
    await NotificationService.showDiseaseDetectionAlert(
      cropName: 'Maize',
      disease: 'Fall Armyworm',
      confidence: 0.92,
    );
  }

  /// Example 3: Show farm reminder
  static Future<void> showFarmReminder() async {
    await NotificationService.showFarmReminder(
      activity: 'Irrigation Schedule',
      details: 'Water your crops at 6 AM tomorrow',
    );
  }

  /// Example 4: Schedule a notification for later
  static Future<void> scheduleNotification() async {
    final scheduledTime = DateTime.now().add(Duration(hours: 2));

    await NotificationService.scheduleNotification(
      title: 'Watering Reminder',
      body: 'Time to water your crops',
      scheduledTime: scheduledTime,
    );
  }

  /// Example 5: Show offline sync notification
  static Future<void> showOfflineNotification() async {
    await NotificationService.showSyncNotification(false); // offline
    await Future.delayed(Duration(seconds: 3));
    await NotificationService.showSyncNotification(true); // back online
  }

  /// Example 6: Get FCM token (for testing)
  static Future<void> getFCMToken() async {
    final token = await NotificationService.getFCMToken();
    print('Your FCM Token: $token');
    // Use this token to test sending notifications from Firebase Console
  }

  /// Example 7: Subscribe to notification topics
  static Future<void> subscribeToTopics() async {
    // Subscribe to crop alerts
    await NotificationService.subscribeToTopic('crop_alerts');

    // Subscribe to weather alerts
    await NotificationService.subscribeToTopic('weather_alerts');

    // Subscribe to market prices
    await NotificationService.subscribeToTopic('market_prices');
  }

  /// Example 8: Unsubscribe from topics
  static Future<void> unsubscribeFromTopics() async {
    await NotificationService.unsubscribeFromTopic('crop_alerts');
    await NotificationService.unsubscribeFromTopic('weather_alerts');
  }

  /// Example 9: Enable/Disable all notifications
  static Future<void> toggleNotifications(bool enable) async {
    await NotificationService.setNotificationsEnabled(enable);

    final status = enable ? 'enabled' : 'disabled';
    print('Notifications $status');
  }

  /// Example 10: Cancel a specific notification
  static Future<void> cancelNotification(int notificationId) async {
    await NotificationService.cancelNotification(notificationId);
  }

  /// Example 11: Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await NotificationService.cancelAllNotifications();
  }
}

/// Example widget showing how to use notifications in a screen
class NotificationTestScreen extends StatefulWidget {
  const NotificationTestScreen({Key? key}) : super(key: key);

  @override
  State<NotificationTestScreen> createState() => _NotificationTestScreenState();
}

class _NotificationTestScreenState extends State<NotificationTestScreen> {
  String? _fcmToken;
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _initializeFCMToken();
  }

  Future<void> _initializeFCMToken() async {
    final token = await NotificationService.getFCMToken();
    setState(() {
      _fcmToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Test')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // FCM Token Display
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'FCM Token (for testing):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SelectableText(
                    _fcmToken ?? 'Loading...',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Token copied to clipboard'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy Token'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Toggle Notifications
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Notifications Enabled'),
                  Switch(
                    value: _notificationsEnabled,
                    onChanged: (value) async {
                      await NotificationService.setNotificationsEnabled(value);
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Test Buttons
          ElevatedButton(
            onPressed: NotificationExamples.showSimpleNotification,
            child: const Text('Show Simple Notification'),
          ),
          const SizedBox(height: 8),

          ElevatedButton(
            onPressed: NotificationExamples.showDiseaseDetectionAlert,
            child: const Text('Show Disease Detection Alert'),
          ),
          const SizedBox(height: 8),

          ElevatedButton(
            onPressed: NotificationExamples.showFarmReminder,
            child: const Text('Show Farm Reminder'),
          ),
          const SizedBox(height: 8),

          ElevatedButton(
            onPressed: NotificationExamples.scheduleNotification,
            child: const Text('Schedule Notification (2 hours)'),
          ),
          const SizedBox(height: 8),

          ElevatedButton(
            onPressed: NotificationExamples.showOfflineNotification,
            child: const Text('Show Offline/Online Status'),
          ),
          const SizedBox(height: 16),

          // Topic Subscription Section
          const Text(
            'Topic Subscriptions',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),

          ElevatedButton(
            onPressed: NotificationExamples.subscribeToTopics,
            child: const Text('Subscribe to All Topics'),
          ),
          const SizedBox(height: 8),

          ElevatedButton(
            onPressed: NotificationExamples.unsubscribeFromTopics,
            child: const Text('Unsubscribe from All Topics'),
          ),
          const SizedBox(height: 16),

          // Clear Notifications
          ElevatedButton(
            onPressed: NotificationExamples.cancelAllNotifications,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear All Notifications'),
          ),
        ],
      ),
    );
  }
}
