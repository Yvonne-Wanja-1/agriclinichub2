import 'package:flutter/foundation.dart';
import 'package:agriclinichub/core/services/notification_service.dart';

/// NotificationLogic handles all notification triggers based on app events
class NotificationLogic {
  /// Triggered when disease is detected during crop scanning
  static Future<void> onDiseaseDetected({
    required String cropName,
    required String mainDisease,
    required double confidence,
    required String severity,
  }) async {
    // Send immediate notification alert
    await NotificationService.showDiseaseDetectionAlert(
      cropName: cropName,
      disease: mainDisease,
      confidence: confidence,
    );

    // Store notification record in local storage
    await _storeNotificationRecord(
      type: 'disease_detection',
      title: 'Disease Detected: $cropName',
      body:
          '$mainDisease (${(confidence * 100).toStringAsFixed(1)}% confidence)',
      metadata: {
        'cropName': cropName,
        'disease': mainDisease,
        'confidence': confidence,
        'severity': severity,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );

    // If high severity, send additional reminder notification
    if (severity == 'severe' || severity == 'critical') {
      await Future.delayed(const Duration(minutes: 5));
      await NotificationService.showFarmReminder(
        activity: 'Urgent Disease Alert',
        details: '$mainDisease on $cropName requires immediate attention',
      );
    }
  }

  /// Triggered when farmer data is successfully submitted
  static Future<void> onFarmerDataSubmitted({
    required String farmerName,
    required String county,
  }) async {
    await NotificationService.showNotification(
      title: 'Profile Updated',
      body: 'Farmer profile for $farmerName in $county updated successfully',
      id: DateTime.now().millisecondsSinceEpoch.hashCode,
    );

    await _storeNotificationRecord(
      type: 'profile_update',
      title: 'Profile Updated',
      body: 'Farmer profile updated successfully',
      metadata: {
        'farmerName': farmerName,
        'county': county,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Triggered when app goes online/offline
  static Future<void> onConnectivityChange(bool isOnline) async {
    await NotificationService.showSyncNotification(isOnline);

    await _storeNotificationRecord(
      type: 'connectivity',
      title: isOnline ? 'Back Online' : 'Offline Mode',
      body: isOnline
          ? 'Syncing data with server...'
          : 'Working in offline mode. Changes will sync when online.',
      metadata: {
        'isOnline': isOnline,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Triggered when scan is completed and saved
  static Future<void> onScanCompleted({
    required String scanId,
    required String cropType,
    required bool foundDiseases,
  }) async {
    final title = foundDiseases
        ? 'Scan Complete - Issues Found'
        : 'Crop Scan Saved';
    final body = foundDiseases
        ? 'Your $cropType scan detected potential issues. Review recommendations.'
        : 'Your $cropType scan has been saved to your history.';

    await NotificationService.showNotification(
      title: title,
      body: body,
      payload: 'scan_history:$scanId',
      id: DateTime.now().millisecondsSinceEpoch.hashCode,
    );

    await _storeNotificationRecord(
      type: 'scan_completed',
      title: title,
      body: body,
      metadata: {
        'scanId': scanId,
        'cropType': cropType,
        'foundDiseases': foundDiseases,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Triggered for periodic farm health reminders
  static Future<void> onFarmHealthReminder({
    required String activity,
    required String description,
    required String priority, // 'low', 'medium', 'high'
  }) async {
    await NotificationService.showFarmReminder(
      activity: activity,
      details: description,
    );

    await _storeNotificationRecord(
      type: 'farm_reminder',
      title: 'Farm Reminder: $activity',
      body: description,
      metadata: {
        'activity': activity,
        'priority': priority,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Triggered when livestock health issue is detected
  static Future<void> onLivestockHealthIssue({
    required String animalType,
    required String issue,
    required String severity,
  }) async {
    final title = 'Livestock Alert: $animalType';
    final body = '$issue detected - Severity: $severity';

    await NotificationService.showNotification(
      title: title,
      body: body,
      id: DateTime.now().millisecondsSinceEpoch.hashCode,
    );

    await _storeNotificationRecord(
      type: 'livestock_alert',
      title: title,
      body: body,
      metadata: {
        'animalType': animalType,
        'issue': issue,
        'severity': severity,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Triggered when weather alert needs to be shown
  static Future<void> onWeatherAlert({
    required String alertType, // 'rain', 'drought', 'frost', 'heatwave'
    required String impact,
    required String recommendation,
  }) async {
    final title = 'Weather Alert: ${alertType.toUpperCase()}';
    final body = impact;

    await NotificationService.showNotification(
      title: title,
      body: body,
      payload: 'weather_alert:$alertType',
      id: DateTime.now().millisecondsSinceEpoch.hashCode,
    );

    await _storeNotificationRecord(
      type: 'weather_alert',
      title: title,
      body: body,
      metadata: {
        'alertType': alertType,
        'impact': impact,
        'recommendation': recommendation,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Triggered when educational content is available
  static Future<void> onNewEducationalContent({
    required String title,
    required String topic,
    required String contentType, // 'article', 'video', 'guide'
  }) async {
    await NotificationService.showNotification(
      title: 'New $contentType Available',
      body: title,
      payload: 'education:$topic:$contentType',
      id: DateTime.now().millisecondsSinceEpoch.hashCode,
    );

    await _storeNotificationRecord(
      type: 'educational_content',
      title: 'New $contentType Available',
      body: title,
      metadata: {
        'topic': topic,
        'contentType': contentType,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Triggered when data sync completes
  static Future<void> onDataSyncCompleted({
    required int scansUploaded,
    required int recordsUpdated,
  }) async {
    final body = scansUploaded > 0
        ? 'Uploaded $scansUploaded scans and updated $recordsUpdated records'
        : 'All data is up to date';

    await NotificationService.showNotification(
      title: 'Data Sync Complete',
      body: body,
      id: 1002,
    );

    await _storeNotificationRecord(
      type: 'data_sync',
      title: 'Data Sync Complete',
      body: body,
      metadata: {
        'scansUploaded': scansUploaded,
        'recordsUpdated': recordsUpdated,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Triggered when crop development milestone is reached
  static Future<void> onCropMilestone({
    required String cropName,
    required String milestone,
    required String nextAction,
  }) async {
    final title = 'Crop Milestone: $cropName';
    final body = '$milestone reached. Next: $nextAction';

    await NotificationService.showNotification(
      title: title,
      body: body,
      payload: 'crop_milestone:$cropName',
      id: DateTime.now().millisecondsSinceEpoch.hashCode,
    );

    await _storeNotificationRecord(
      type: 'crop_milestone',
      title: title,
      body: body,
      metadata: {
        'cropName': cropName,
        'milestone': milestone,
        'nextAction': nextAction,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Store notification in local history
  static Future<void> _storeNotificationRecord({
    required String type,
    required String title,
    required String body,
    required Map<String, dynamic> metadata,
  }) async {
    try {
      // Note: This requires a notifications box in LocalStorageService
      // You may need to add this to local_storage_service.dart
      // For now, we'll skip storing to avoid errors
      debugPrint('Notification record: $type - $title');
    } catch (e) {
      debugPrint('Error storing notification record: $e');
    }
  }

  /// Get all notifications from local storage
  static List<Map<String, dynamic>> getAllNotifications() {
    // To be implemented when notifications box is added to LocalStorageService
    return [];
  }

  /// Mark notification as read
  static Future<void> markAsRead(String notificationId) async {
    // To be implemented when notifications box is added to LocalStorageService
  }

  /// Clear all notifications
  static Future<void> clearAllNotifications() async {
    await NotificationService.cancelAllNotifications();
    // Also clear from local storage when implemented
  }
}
