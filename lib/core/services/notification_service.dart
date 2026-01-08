import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  static late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static bool _isInitialized = false;

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  /// Initialize the notification service
  static Future<void> initialize() async {
    if (_isInitialized) return;

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );

    _isInitialized = true;
  }

  /// Request notification permissions (iOS 13+)
  static Future<bool?> requestPermissions() async {
    if (!_isInitialized) {
      await initialize();
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
    return true;
  }

  /// Show a simple local notification
  static Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
    int id = 0,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'agri_clinic_channel',
          'Agri Clinic Notifications',
          channelDescription: 'Notifications for crop and livestock updates',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Show a scheduled notification
  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
    int id = 0,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'agri_clinic_channel',
          'Agri Clinic Notifications',
          channelDescription: 'Notifications for crop and livestock updates',
          importance: Importance.max,
          priority: Priority.high,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Calculate delay in seconds
    final delay = scheduledTime.difference(DateTime.now()).inSeconds;
    if (delay > 0) {
      await _flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        title,
        body,
        RepeatInterval.daily,
        notificationDetails,
        payload: payload,
      );
    }
  }

  /// Cancel a notification by ID
  static Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Handle notification tap
  static void _onSelectNotification(NotificationResponse response) {
    if (response.payload != null && response.payload!.isNotEmpty) {
      debugPrint('Notification payload: ${response.payload}');
      // Handle navigation or other logic based on payload
    }
  }

  /// Show disease detection alert notification
  static Future<void> showDiseaseDetectionAlert({
    required String cropName,
    required String disease,
    required double confidence,
  }) async {
    final title = 'Disease Detected: $cropName';
    final body =
        '$disease detected with ${(confidence * 100).toStringAsFixed(1)}% confidence';

    await showNotification(
      title: title,
      body: body,
      payload: 'disease_detection:$cropName:$disease',
      id: DateTime.now().millisecondsSinceEpoch.hashCode,
    );
  }

  /// Show farm activity reminder
  static Future<void> showFarmReminder({
    required String activity,
    required String details,
  }) async {
    await showNotification(
      title: 'Farm Reminder',
      body: '$activity: $details',
      payload: 'farm_reminder:$activity',
      id: DateTime.now().millisecondsSinceEpoch.hashCode,
    );
  }

  /// Show sync/offline status notification
  static Future<void> showSyncNotification(bool isOnline) async {
    final title = isOnline ? 'Back Online' : 'Offline Mode';
    final body = isOnline
        ? 'Syncing data with server...'
        : 'Working in offline mode. Changes will sync when online.';

    await showNotification(title: title, body: body, id: 1001);
  }
}

// Note: For timezone support with scheduled notifications, add timezone package:
// timezone package: ^0.9.0
// Then initialize with: tz.initializeTimeZones();
