# Notification System Documentation

## Overview
The Agri Clinic Hub notification system provides real-time alerts and reminders for farming activities, disease detection, connectivity status, and other important events.

## Architecture

### Core Components

1. **NotificationService** (`core/services/notification_service.dart`)
   - Handles low-level notification rendering
   - Manages Android and iOS notification channels
   - Handles notification permissions and lifecycle

2. **NotificationLogic** (`core/services/notification_logic.dart`)
   - High-level business logic for when to trigger notifications
   - Provides domain-specific notification methods
   - Stores notification history (ready for local storage integration)

3. **ConnectivityListener** (`core/services/connectivity_listener.dart`)
   - Monitors network connectivity changes
   - Triggers sync notifications
   - Automatically syncs data when connection is restored

## Integration Points

### Disease Detection
```dart
// In disease_detection_service.dart
// Automatically triggered when disease is detected
await NotificationLogic.onDiseaseDetected(
  cropName: 'Tomato',
  mainDisease: 'Early Blight',
  confidence: 0.85,
  severity: 'moderate',
);
```

### Farmer Data Submission
```dart
// In farmer_service.dart
// Automatically triggered when farmer data is submitted
await NotificationLogic.onFarmerDataSubmitted(
  farmerName: 'John Mwangi',
  county: 'Kiambu',
);
```

### Connectivity Changes
```dart
// In connectivity_listener.dart
// Automatically triggered on network status change
await NotificationLogic.onConnectivityChange(isOnline);
```

## Available Notification Methods

### Disease Detection Alert
```dart
await NotificationLogic.onDiseaseDetected(
  cropName: String,
  mainDisease: String,
  confidence: double,
  severity: String,
);
```

### Farmer Data Updated
```dart
await NotificationLogic.onFarmerDataSubmitted(
  farmerName: String,
  county: String,
);
```

### Connectivity Status
```dart
await NotificationLogic.onConnectivityChange(bool isOnline);
```

### Scan Completed
```dart
await NotificationLogic.onScanCompleted(
  scanId: String,
  cropType: String,
  foundDiseases: bool,
);
```

### Farm Health Reminder
```dart
await NotificationLogic.onFarmHealthReminder(
  activity: String,
  description: String,
  priority: String, // 'low', 'medium', 'high'
);
```

### Livestock Health Issue
```dart
await NotificationLogic.onLivestockHealthIssue(
  animalType: String,
  issue: String,
  severity: String,
);
```

### Weather Alert
```dart
await NotificationLogic.onWeatherAlert(
  alertType: String, // 'rain', 'drought', 'frost', 'heatwave'
  impact: String,
  recommendation: String,
);
```

### Educational Content
```dart
await NotificationLogic.onNewEducationalContent(
  title: String,
  topic: String,
  contentType: String, // 'article', 'video', 'guide'
);
```

### Data Sync Completed
```dart
await NotificationLogic.onDataSyncCompleted(
  scansUploaded: int,
  recordsUpdated: int,
);
```

### Crop Milestone
```dart
await NotificationLogic.onCropMilestone(
  cropName: String,
  milestone: String,
  nextAction: String,
);
```

## Usage Example

### Add Notification to a Feature Screen

```dart
import 'package:agriclinichub/core/services/notification_logic.dart';

class MyFeatureScreen extends StatefulWidget {
  @override
  State<MyFeatureScreen> createState() => _MyFeatureScreenState();
}

class _MyFeatureScreenState extends State<MyFeatureScreen> {
  Future<void> _handleAction() async {
    try {
      // Your business logic here
      
      // Trigger appropriate notification
      await NotificationLogic.onFarmHealthReminder(
        activity: 'Watering',
        description: 'Time to water your tomato plants',
        priority: 'medium',
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _handleAction,
          child: const Text('Perform Action'),
        ),
      ),
    );
  }
}
```

## Platform Requirements

### Android
- Min SDK: 21
- Requires `android.permission.POST_NOTIFICATIONS` (Android 13+)
- Channel ID: `agri_clinic_channel`

### iOS
- Min iOS: 10.0
- Requires user permission for alerts, badges, and sounds
- Notifications work in both foreground and background

## Future Enhancements

1. **Notification History**
   - Add notifications box to `LocalStorageService`
   - Implement `getAllNotifications()` method
   - Add UI screen to display notification history

2. **Scheduled Notifications**
   - Integrate `timezone` package for advanced scheduling
   - Enable crop lifecycle reminders
   - Weather-based scheduling

3. **Custom Notification Actions**
   - Action buttons in notifications
   - Quick replies
   - Navigation to relevant screens

4. **Notification Preferences**
   - Allow users to enable/disable notification categories
   - Custom sound and vibration settings
   - Quiet hours scheduling

5. **Analytics**
   - Track notification engagement
   - Monitor notification delivery success
   - User interaction metrics

## Troubleshooting

### Notifications Not Appearing
1. Check if `NotificationService.initialize()` is called in `main.dart`
2. Verify permissions are granted in app settings
3. Check device notification settings for the app

### Missing Notifications in Background
- Ensure `flutter_local_notifications` is properly configured
- For Android, verify the notification channel is created
- For iOS, verify remote notification permissions

### Errors in Notification Logic
- Ensure all services are properly imported
- Check that notification service is initialized before use
- Verify BuildContext is available when needed
