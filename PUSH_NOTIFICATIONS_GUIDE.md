# Push Notifications Implementation Guide

This guide explains how push notifications (FCM) have been implemented in the Agri Clinic Hub application.

## Overview

The app now supports both **local notifications** (device-only) and **push notifications** (Firebase Cloud Messaging - FCM). Push notifications allow the server to send messages directly to user devices even when the app is in the background or not running.

## Architecture

### Components

1. **FirebaseMessagingService** (`lib/core/services/firebase_messaging_service.dart`)
   - Handles FCM initialization and configuration
   - Manages message handlers for different states (foreground, background, terminated)
   - Provides methods to subscribe/unsubscribe from topics
   - Manages FCM token retrieval and storage

2. **NotificationService** (`lib/core/services/notification_service.dart`)
   - Unified notification interface for local and push notifications
   - Shows notifications in all app states
   - Handles notification tapping and routing
   - Integrates with FirebaseMessagingService

3. **Background Message Handler** (`lib/firebase_messaging_background_handler.dart`)
   - Top-level function to handle messages when app is terminated
   - Ensures notifications are shown even if app is closed

### Message Flow

```
Firebase Cloud → FirebaseMessagingService
                        ↓
                 Message Handler (based on state)
                        ↓
                 NotificationService
                        ↓
                 Show Local Notification
                        ↓
                 Route based on payload
```

## Setup Instructions

### 1. Prerequisites

Ensure the following packages are in `pubspec.yaml`:
- `firebase_core: ^2.21.0`
- `firebase_messaging: ^14.7.0`
- `flutter_local_notifications: ^17.0.0`

### 2. Firebase Configuration

#### Android Setup

1. **Download google-services.json**
   - Go to Firebase Console → Project Settings
   - Download `google-services.json`
   - Place it in: `android/app/google-services.json`

2. **Enable FCM API** (if not already enabled)
   - In Firebase Console, enable "Cloud Messaging API"

3. **AndroidManifest.xml**
   - The manifest should have internet permission:
   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   ```

#### iOS Setup

1. **Configure APNs Certificate**
   - Go to Firebase Console → Project Settings → Cloud Messaging
   - Upload your APNs certificate or key

2. **Update Runner project**
   - Open `ios/Runner.xcworkspace` (NOT the .xcodeproj)
   - In Build Settings, ensure:
     - Team ID is set
     - Bundle Identifier matches Firebase app

3. **Add Capabilities**
   - In Xcode: Runner → Signing & Capabilities
   - Add "Push Notifications" capability
   - Add "Background Modes" → "Remote notifications"

4. **Update Info.plist** (if using Xcode)
   - Ensure notification permissions are requested in iOS 10+

### 3. Testing Push Notifications

#### Get FCM Token (for testing)

```dart
String? token = await NotificationService.getFCMToken();
print('FCM Token: $token');
```

Save this token to test sending notifications via Firebase Console.

#### Send Test Notification via Firebase Console

1. Go to Firebase Console → Cloud Messaging → Send your first message
2. Enter notification title and body
3. In "Additional options" (Target section):
   - Select "Single device"
   - Paste the FCM token
4. Click "Send"

#### Test in Different States

- **Foreground**: App open → should show system notification
- **Background**: App in background → notification appears in system tray
- **Terminated**: App closed → notification appears, tap launches app

## Notification Payload Structure

When sending notifications from your server, use this payload structure:

```json
{
  "notification": {
    "title": "Notification Title",
    "body": "Notification Body"
  },
  "data": {
    "type": "disease_alert",
    "cropName": "Maize",
    "disease": "Fall Armyworm",
    "confidence": "0.95"
  }
}
```

### Supported Types

- **disease_alert**: Routes to disease/crop details page
  - Required fields: `cropName`, `disease`, `confidence`

- **farm_reminder**: Routes to farm management page
  - Required fields: `activity`, `details`

- **article**: Routes to articles/education section
  - Required fields: `articleId`, `title`

- **system_update**: Handles system-level notifications
  - Required fields: `message`, `version`

## Topic Subscriptions

Users can subscribe to notification topics for group notifications:

```dart
// Subscribe to topic
await NotificationService.subscribeToTopic('crop_alerts');

// Unsubscribe from topic
await NotificationService.unsubscribeFromTopic('crop_alerts');
```

### Common Topics

- `crop_alerts`: Disease and pest alerts
- `weather_alerts`: Weather-related notifications
- `market_prices`: Market price updates
- `educational_content`: New articles and resources
- `system_updates`: App updates and announcements

## Notification Permissions

### Android (13+)

Permissions are automatically requested at runtime via `flutter_local_notifications`.

### iOS (13+)

Permissions are requested via `flutter_local_notifications` during app initialization.

Users can change notification settings:
- Settings → AgriClinicHub → Notifications

## Enable/Disable Notifications

```dart
// Disable all notifications
await NotificationService.setNotificationsEnabled(false);

// Enable notifications again
await NotificationService.setNotificationsEnabled(true);
```

## Handling Notification Taps

When a user taps a notification, the payload data is used to navigate:

```dart
// In firebase_messaging_service.dart, the _routeBasedOnNotification() method
// handles routing based on notification type
```

To add custom routing for a new notification type:

1. Add case in `_routeBasedOnNotification()` method
2. Implement navigation logic
3. Return appropriate route data

## Troubleshooting

### Notifications Not Appearing

1. **Check FCM token**
   ```dart
   String? token = await NotificationService.getFCMToken();
   print('Token: $token');
   ```

2. **Verify permissions**
   - iOS: Settings → AgriClinicHub → Notifications (enabled)
   - Android: App info → Notifications (enabled)

3. **Check Firebase Console**
   - Verify google-services.json is properly placed
   - Check Cloud Messaging API is enabled

4. **Enable Debug Logging**
   ```dart
   // In firebase_messaging_service.dart, debug prints are shown in console
   ```

### Token Not Refreshing

- Ensure `firebase_messaging_service.dart` initializes properly in `NotificationService.initialize()`
- Check that background handler is set up in `main.dart`

### Background Messages Not Working

1. Verify `firebaseMessagingBackgroundHandler` is registered in `main.dart`
2. Check Android Doze mode doesn't affect testing
3. Ensure app has necessary permissions

## Server-Side Integration

When sending notifications from your backend:

1. **Retrieve FCM tokens** - Store user FCM tokens in Firestore or your backend
2. **Construct payload** - Use the structure mentioned above
3. **Send via Firebase Admin SDK**:

```javascript
// Node.js Example
const admin = require('firebase-admin');

const message = {
  notification: {
    title: 'Disease Alert',
    body: 'Fall Armyworm detected in Maize'
  },
  data: {
    type: 'disease_alert',
    cropName: 'Maize',
    disease: 'Fall Armyworm',
    confidence: '0.95'
  },
  token: userFCMToken
};

await admin.messaging().send(message);
```

## Advanced Features

### Rich Notifications (Android)

For images in notifications, modify `NotificationService`:

```dart
final androidNotificationDetails = AndroidNotificationDetails(
  'agri_clinic_channel',
  'Agri Clinic Notifications',
  largeIcon: const AndroidBitmap('app_icon'),
  styleInformation: const BigPictureStyleInformation(
    AndroidBitmap('image_id'),
    contentTitle: 'title',
    htmlFormatContentTitle: true,
  ),
);
```

### Custom Sounds (iOS & Android)

Add custom sound file and reference in notification details:

```dart
const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
  sound: 'alert.caf',
  presentAlert: true,
  presentBadge: true,
  presentSound: true,
);
```

## Best Practices

1. **Frequency**: Limit notifications to avoid user fatigue
2. **Timing**: Send at appropriate times (avoid nighttime)
3. **Relevance**: Only send notifications users care about
4. **Localization**: Translate notification titles and bodies
5. **Testing**: Test all notification states before deployment
6. **Opt-in**: Allow users to manage notification preferences

## File Reference

- Configuration: `/lib/core/services/firebase_messaging_service.dart`
- Local notifications: `/lib/core/services/notification_service.dart`
- Background handler: `/lib/firebase_messaging_background_handler.dart`
- Main initialization: `/lib/main.dart`

## Support

For issues or questions:
1. Check Firebase Console logs
2. Review Flutter Firebase documentation
3. Check Android/iOS-specific logs in Studio/Xcode
