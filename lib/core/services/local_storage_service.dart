import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  static late Box<Map<String, dynamic>> _scanBox;
  static late Box<Map<String, dynamic>> _farmerBox;
  static late Box<Map<String, dynamic>> _settingsBox;

  // Initialize Hive local storage
  static Future<void> initialize() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);

    _scanBox = await Hive.openBox<Map<String, dynamic>>('scans');
    _farmerBox = await Hive.openBox<Map<String, dynamic>>('farmer');
    _settingsBox = await Hive.openBox<Map<String, dynamic>>('settings');
  }

  // Save scan result locally
  static Future<void> saveScanLocally(
    String scanId,
    Map<String, dynamic> scanData,
  ) async {
    try {
      await _scanBox.put(scanId, scanData);
    } catch (e) {
      rethrow;
    }
  }

  // Get all scans from local storage
  static List<Map<String, dynamic>> getAllScans() {
    try {
      return _scanBox.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  // Get single scan by ID
  static Map<String, dynamic>? getScanById(String scanId) {
    try {
      return _scanBox.get(scanId);
    } catch (e) {
      rethrow;
    }
  }

  // Delete scan
  static Future<void> deleteScan(String scanId) async {
    try {
      await _scanBox.delete(scanId);
    } catch (e) {
      rethrow;
    }
  }

  // Save farmer profile
  static Future<void> saveFarmerProfile(
    Map<String, dynamic> profileData,
  ) async {
    try {
      await _farmerBox.put('profile', profileData);
    } catch (e) {
      rethrow;
    }
  }

  // Get farmer profile
  static Map<String, dynamic>? getFarmerProfile() {
    try {
      return _farmerBox.get('profile');
    } catch (e) {
      rethrow;
    }
  }

  // Save app settings
  static Future<void> saveSetting(String key, dynamic value) async {
    try {
      final settings = _settingsBox.get('settings') ?? {};
      settings[key] = value;
      await _settingsBox.put('settings', settings);
    } catch (e) {
      rethrow;
    }
  }

  // Get app settings
  static dynamic getSetting(String key) {
    try {
      final settings = _settingsBox.get('settings') ?? {};
      return settings[key];
    } catch (e) {
      rethrow;
    }
  }

  // Clear all data
  static Future<void> clearAllData() async {
    try {
      await _scanBox.clear();
      await _farmerBox.clear();
      await _settingsBox.clear();
    } catch (e) {
      rethrow;
    }
  }

  // Get sync queue (scans that need to be synced)
  static List<Map<String, dynamic>> getSyncQueue() {
    try {
      final scans = _scanBox.values.toList();
      return scans.where((scan) => scan['synced'] == false).toList();
    } catch (e) {
      rethrow;
    }
  }
}
