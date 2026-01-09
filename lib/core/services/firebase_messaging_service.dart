import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'notification_service.dart';

/// Service to handle Firebase Cloud Messaging (FCM) for push notifications
class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();
  static late FirebaseMessaging _firebaseMessaging;
  static bool _isInitialized = false;

  // Stream controllers for notification events
  static final ValueNotifier<RemoteMessage?> lastMessage =
      ValueNotifier<RemoteMessage?>(null);

  factory FirebaseMessagingService() {
    return _instance;
  }

  FirebaseMessagingService._internal();

  /// Initialize Firebase Messaging
  static Future<void> initialize() async {
    if (_isInitialized) return;

    _firebaseMessaging = FirebaseMessaging.instance;

    // Request notification permissions
    await _requestPermissions();

    // Setup message handlers
    _setupMessageHandlers();

    // Handle notification tap from termination state
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Get FCM token and store it for later use (for testing)
    await _getFCMToken();

    _isInitialized = true;
    debugPrint('Firebase Messaging initialized successfully');
  }

  /// Request user permissions for notifications
  static Future<void> _requestPermissions() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carefullyProvisionalAlert: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    debugPrint(
      'User notification permission status: ${settings.authorizationStatus}',
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint('User declined or has not accepted notification permissions');
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted notification permissions');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional notification permissions');
    }
  }

  /// Setup message handlers for different scenarios
  static void _setupMessageHandlers() {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Received foreground message: ${message.messageId}');
      lastMessage.value = message;
      _handleForegroundMessage(message);
    });

    // Handle background message (when app is in background or terminated)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Message opened from background: ${message.messageId}');
      _handleMessage(message);
    });

    // Handle token refresh
    _firebaseMessaging.onTokenRefresh.listen((String token) {
      debugPrint('FCM Token refreshed: $token');
      // Store the new token or send it to your backend
      _storeFCMToken(token);
    });
  }

  /// Handle foreground messages by showing local notification
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;
    final data = message.data;

    if (notification != null) {
      // Show local notification with the data from remote message
      await NotificationService.showNotification(
        title: notification.title ?? 'Notification',
        body: notification.body ?? '',
        payload: _encodePayload(data),
        id: DateTime.now().millisecondsSinceEpoch.hashCode,
      );
    }
  }

  /// Handle message tap and navigation
  static void _handleMessage(RemoteMessage message) {
    final data = message.data;
    debugPrint('Handling message with data: $data');

    // Route based on notification type
    _routeBasedOnNotification(data);
  }

  /// Route to appropriate screen based on notification data
  static void _routeBasedOnNotification(Map<String, dynamic> data) {
    final type = data['type'] ?? 'general';

    switch (type) {
      case 'disease_alert':
        // Navigate to disease detection or crop details screen
        _navigateToDiseasePage(data);
        break;
      case 'farm_reminder':
        // Navigate to farm management or crop calendar
        _navigateToFarmPage(data);
        break;
      case 'article':
        // Navigate to articles/education section
        _navigateToArticle(data);
        break;
      case 'system_update':
        // Handle system update notification
        _handleSystemUpdate(data);
        break;
      default:
        debugPrint('Unknown notification type: $type');
    }
  }

  static void _navigateToDiseasePage(Map<String, dynamic> data) {
    // This will be handled by the app router in main
    // For now, just store the data
    debugPrint(
      'Navigating to disease page: ${data['cropName']} - ${data['disease']}',
    );
  }

  static void _navigateToFarmPage(Map<String, dynamic> data) {
    debugPrint('Navigating to farm page: ${data['activity']}');
  }

  static void _navigateToArticle(Map<String, dynamic> data) {
    debugPrint('Navigating to article: ${data['articleId']}');
  }

  static void _handleSystemUpdate(Map<String, dynamic> data) {
    debugPrint('System update notification: ${data['message']}');
  }

  /// Get FCM token for sending targeted messages
  static Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  /// Store FCM token (implement this to save to your backend)
  static Future<void> _storeFCMToken(String token) async {
    // TODO: Store token in Firestore or your backend
    // This allows you to send notifications to specific users
    debugPrint('FCM Token should be stored: $token');
  }

  /// Get FCM token and log it
  static Future<void> _getFCMToken() async {
    final token = await _firebaseMessaging.getToken();
    if (token != null) {
      debugPrint('FCM Token: $token');
      await _storeFCMToken(token);
    }
  }

  /// Send test notification (for development)
  static Future<void> sendTestNotification({
    required String title,
    required String body,
    Map<String, String>? data,
  }) async {
    // Show local notification for testing
    await NotificationService.showNotification(
      title: title,
      body: body,
      payload: _encodePayload(data ?? {}),
      id: DateTime.now().millisecondsSinceEpoch.hashCode,
    );
  }

  /// Encode payload to string for notification
  static String _encodePayload(Map<String, dynamic> data) {
    return data.entries.map((e) => '${e.key}=${e.value}').join('|');
  }

  /// Decode payload from notification
  static Map<String, String> decodePayload(String? payload) {
    if (payload == null || payload.isEmpty) return {};
    final map = <String, String>{};
    final pairs = payload.split('|');
    for (final pair in pairs) {
      if (pair.contains('=')) {
        final kv = pair.split('=');
        if (kv.length == 2) {
          map[kv[0]] = kv[1];
        }
      }
    }
    return map;
  }

  /// Subscribe to topic for receiving group notifications
  static Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    debugPrint('Subscribed to topic: $topic');
  }

  /// Unsubscribe from topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    debugPrint('Unsubscribed from topic: $topic');
  }

  /// Enable/disable notifications
  static Future<void> setNotificationsEnabled(bool enabled) async {
    if (enabled) {
      await _firebaseMessaging.setAutoInitEnabled(true);
      debugPrint('Notifications enabled');
    } else {
      await _firebaseMessaging.setAutoInitEnabled(false);
      debugPrint('Notifications disabled');
    }
  }
}
