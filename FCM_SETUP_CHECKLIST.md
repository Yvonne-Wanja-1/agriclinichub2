# Firebase Cloud Messaging (FCM) Setup Checklist

## Quick Setup Checklist

Use this checklist to ensure your app is fully configured for push notifications.

### ✅ Firebase Project Setup

- [ ] Firebase project created in [Firebase Console](https://console.firebase.google.com)
- [ ] iOS app registered in Firebase project
- [ ] Android app registered in Firebase project
- [ ] Cloud Messaging API enabled in Google Cloud Console
- [ ] Billing enabled on the Google Cloud project (required for FCM)

### ✅ Android Configuration

- [ ] `google-services.json` downloaded from Firebase Console
- [ ] `google-services.json` placed in `android/app/`
- [ ] Google Play Services dependency in `android/build.gradle.kts`
- [ ] Internet permission added to AndroidManifest.xml
- [ ] App tested on Android device/emulator

**Commands to test:**
```bash
flutter run -d <device_id>  # Run on specific device
flutter run                   # Run on default device
```

### ✅ iOS Configuration

- [ ] APNs certificate uploaded to Firebase Console (Production or Development)
- [ ] Bundle ID matches Firebase app configuration
- [ ] Team ID set in Xcode signing settings
- [ ] Push Notifications capability added in Xcode
- [ ] Remote notifications background mode enabled
- [ ] Info.plist updated with notification settings
- [ ] App tested on iOS device (not simulator for real notifications)

**Steps:**

1. Open `ios/Runner.xcworkspace` (NOT .xcodeproj)
2. Select "Runner" project in sidebar
3. Select "Runner" target
4. Go to "Signing & Capabilities" tab
5. Click "+ Capability"
6. Add "Push Notifications"
7. Add "Background Modes" and check "Remote notifications"

### ✅ Code Integration

- [ ] `firebase_messaging` added to `pubspec.yaml`
- [ ] `firebase_options.dart` generated (run: `flutterfire configure`)
- [ ] `FirebaseMessagingService` created and imported
- [ ] Background message handler set up in `main.dart`
- [ ] `NotificationService.initialize()` called in `main()`
- [ ] Notification permissions requested at startup

### ✅ Testing

#### Get FCM Token

```dart
// In your app or via console
String? token = await NotificationService.getFCMToken();
print('FCM Token: $token');
```

#### Send Test Notification via Firebase Console

1. Navigate to Cloud Messaging in Firebase Console
2. Click "Send your first message"
3. Enter:
   - Title: `Test Notification`
   - Body: `This is a test message`
4. Click "Next"
5. In "Target" section, select "Single device"
6. Paste the FCM token
7. Click "Send"

#### Verify in Different States

| State | Action | Expected Result |
|-------|--------|-----------------|
| Foreground | App open, send notification | Notification appears in-app |
| Background | App minimized, send notification | Notification in system tray |
| Terminated | App closed, send notification | Notification appears, tap launches app |

### ✅ Database Setup (Optional)

To enable sending notifications to specific users from your backend:

**Firestore Collection: `user_tokens`**

```json
{
  "uid": "user123",
  "fcmTokens": [
    "token_1",
    "token_2"
  ],
  "lastUpdated": "2026-01-09T10:30:00Z"
}
```

**Store user tokens when app starts:**

```dart
// In a settings service or user profile service
await storeUserFCMToken();

Future<void> storeUserFCMToken() async {
  final token = await NotificationService.getFCMToken();
  if (token != null && user != null) {
    await FirebaseFirestore.instance
        .collection('user_tokens')
        .doc(user!.uid)
        .set({
          'uid': user!.uid,
          'fcmTokens': FieldValue.arrayUnion([token]),
          'lastUpdated': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
  }
}
```

## Troubleshooting

### Problem: Firebase options not configured for platform

**Solution:** Run FlutterFire CLI configuration:
```bash
flutter pub global activate flutterfire_cli
flutterfire configure --project=your-project-id
```

### Problem: android/app/google-services.json not found

**Solution:**
1. Go to Firebase Console → Project Settings
2. Download `google-services.json`
3. Place in `android/app/` directory
4. Run `flutter clean` and rebuild

### Problem: FCM token is null

**Solution:**
1. Verify Firebase initialization completed
2. Check Google Play Services on Android device
3. Check internet connectivity
4. Check that Cloud Messaging API is enabled

### Problem: Notifications not showing on iOS

**Solution:**
1. Verify APNs certificate uploaded to Firebase
2. Test on physical device (not simulator)
3. Check notification settings: Settings → YourApp → Notifications
4. Verify app permissions in iOS settings

### Problem: Background messages not working

**Solution:**
1. Verify `firebaseMessagingBackgroundHandler` is set in `main.dart`
2. Ensure handler function has `@pragma('vm:entry-point')` annotation
3. Test on physical device (simulators have limitations)
4. Check battery saver/Doze mode isn't interfering

## Environment Variables (Optional)

Create a `.env` file for FCM configuration:

```
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_WEB_API_KEY=your-web-api-key
FIREBASE_APP_ID=your-app-id
FIREBASE_MESSAGING_SENDER_ID=your-sender-id
```

Load in app:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  // ... rest of initialization
}
```

## References

- [Firebase Cloud Messaging Documentation](https://firebase.google.com/docs/cloud-messaging)
- [FlutterFire Firebase Messaging](https://firebase.flutter.dev/docs/messaging/overview)
- [flutter_local_notifications Plugin](https://pub.dev/packages/flutter_local_notifications)
- [Android FCM Setup](https://developer.android.com/google/play-services/setup)
- [iOS APNs Setup](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server)
