import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;

  // Authentication methods
  static Future<UserCredential> signUp(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> login(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Firestore methods for farmer profiles
  static Future<void> createFarmerProfile({
    required String userId,
    required Map<String, dynamic> profileData,
  }) async {
    try {
      await _firestore.collection('farmers').doc(userId).set(profileData);
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> getFarmerProfile(String userId) async {
    try {
      final doc = await _firestore.collection('farmers').doc(userId).get();
      return doc.data();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateFarmerProfile(
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection('farmers').doc(userId).update(data);
    } catch (e) {
      rethrow;
    }
  }

  // Store scan results
  static Future<void> saveScanResult({
    required String userId,
    required Map<String, dynamic> scanData,
  }) async {
    try {
      await _firestore
          .collection('farmers')
          .doc(userId)
          .collection('scans')
          .add(scanData);
    } catch (e) {
      rethrow;
    }
  }

  // Retrieve scan history
  static Future<List<Map<String, dynamic>>> getScanHistory(
    String userId,
  ) async {
    try {
      final snapshots = await _firestore
          .collection('farmers')
          .doc(userId)
          .collection('scans')
          .orderBy('date', descending: true)
          .get();
      return snapshots.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      rethrow;
    }
  }

  // Upload image to Firebase Storage
  static Future<String> uploadImage({
    required String userId,
    required String fileName,
    required List<int> fileBytes,
  }) async {
    try {
      final ref = _storage.ref().child('farmers/$userId/scans/$fileName');
      await ref.putData(Uint8List.fromList(fileBytes));
      return await ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  // Stream for real-time updates
  static Stream<QuerySnapshot> getScanHistoryStream(String userId) {
    return _firestore
        .collection('farmers')
        .doc(userId)
        .collection('scans')
        .orderBy('date', descending: true)
        .snapshots();
  }
}
