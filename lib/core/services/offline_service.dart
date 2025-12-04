import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineService {
  static final _connectivity = Connectivity();

  // Check if device is connected to internet
  static Future<bool> isOnline() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }

  // Stream for connectivity changes
  static Stream<bool> connectivityStream() {
    return _connectivity.onConnectivityChanged.map(
      (result) => result != ConnectivityResult.none,
    );
  }

  // Get sync status
  static Future<Map<String, dynamic>> getSyncStatus() async {
    final online = await isOnline();
    return {
      'isOnline': online,
      'lastSync': DateTime.now(),
      'pendingSync': online ? 0 : 1,
    };
  }

  // Queue scan for sync when online
  static Future<void> queueForSync(Map<String, dynamic> scanData) async {
    // Add logic to queue data for syncing
    // This would typically involve saving to local storage
    // and marking as pending sync
  }

  // Sync pending data when online
  static Future<void> syncPendingData() async {
    final online = await isOnline();
    if (!online) {
      throw Exception('No internet connection');
    }
    // Implement sync logic
  }
}
