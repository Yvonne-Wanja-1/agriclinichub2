// Background message handler for Firebase Messaging
// This file handles messages received when the app is terminated

import 'package:firebase_messaging/firebase_messaging.dart';
import 'core/services/notification_service.dart';

/// Top-level function to handle background messages
/// This must be a top-level function, not a class method
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the message even if the app is in the background
  print('Handling a background message: ${message.messageId}');

  final notification = message.notification;
  if (notification != null) {
    await NotificationService.showNotification(
      title: notification.title ?? 'Notification',
      body: notification.body ?? '',
      payload: _encodePayload(message.data),
      id: DateTime.now().millisecondsSinceEpoch.hashCode,
    );
  }
}

/// Encode payload to string
String _encodePayload(Map<String, dynamic> data) {
  return data.entries.map((e) => '${e.key}=${e.value}').join('|');
}
