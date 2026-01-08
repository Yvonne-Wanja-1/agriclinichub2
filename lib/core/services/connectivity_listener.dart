import 'package:agriclinichub/core/services/offline_service.dart';
import 'package:agriclinichub/core/services/notification_logic.dart';

/// ConnectivityListener monitors network status and triggers notifications
class ConnectivityListener {
  static bool _lastKnownStatus = true;
  static bool _initialized = false;

  /// Initialize connectivity monitoring
  static Future<void> initialize() async {
    if (_initialized) return;

    // Get initial status
    _lastKnownStatus = await OfflineService.isOnline();

    // Listen to connectivity changes
    OfflineService.connectivityStream().listen((isOnline) async {
      // Only trigger notification if status actually changed
      if (isOnline != _lastKnownStatus) {
        _lastKnownStatus = isOnline;
        await NotificationLogic.onConnectivityChange(isOnline);

        // If coming back online, trigger a sync
        if (isOnline) {
          await _triggerDataSync();
        }
      }
    });

    _initialized = true;
  }

  /// Trigger data sync when connection is restored
  static Future<void> _triggerDataSync() async {
    try {
      // Implement your sync logic here
      // For now, show a generic sync notification
      await NotificationLogic.onDataSyncCompleted(
        scansUploaded: 0,
        recordsUpdated: 0,
      );
    } catch (e) {
      print('Error syncing data: $e');
    }
  }

  /// Get current connectivity status
  static Future<bool> isOnline() => OfflineService.isOnline();
}
