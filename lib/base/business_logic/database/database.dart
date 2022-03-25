import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:receipts/base/business_logic/database/models/model.dart';
import 'package:receipts/base/business_logic/storage/storage.dart';
import 'package:uuid/uuid.dart';

/// Interface for remote database
abstract class Database {
  /// Creates a new receipt
  Future<void> createReceipt({
    required String userId,
    required String title,
    required String description,
    required String localFilePath,
  });

  /// Updates an existing receipt
  Future<void> updateReceipt({
    required String id,
    required String userId,
    String? title,
    String? description,
    String? localFilePath,
  });

  /// Deletes an existing receipt
  Future<void> deleteReceipt({
    required String id,
    required String userId,
  });

  /// Streams of [List<Receipt>] based on changes to the receipt database
  Stream<List<Receipt>> stream(String userId);
}

/// Firebase Cloud Firestore
class FireDatabase extends Database {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final FireStorage _storage = FireStorage();
  final _uuid = const Uuid();

  @override
  Future<void> createReceipt({
    required String userId,
    required String title,
    required String description,
    required String localFilePath,
  }) async {
    final filePath =
        await _storage.uploadFile(userId: userId, localFilePath: localFilePath);
    final id = _uuid.v4();
    final map = {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'file_path': filePath,
    };
    await _instance.collection(userId).doc(id).set(map);
  }

  @override
  Future<void> deleteReceipt({
    required String id,
    required String userId,
  }) async {
    await _instance
        .collection(userId)
        .doc(id)
        .delete()
        .catchError((Object err) => debugPrint('Failed to delete user: $err'));
  }

  @override
  Future<void> updateReceipt({
    required String id,
    required String userId,
    String? title,
    String? description,
    String? localFilePath,
  }) async {
    final Map<String, String?> map;
    if (localFilePath != null) {
      final filePath = await _storage.uploadFile(
        userId: userId,
        localFilePath: localFilePath,
      );
      map = {
        'title': title,
        'description': description,
        'file_path': filePath,
      };
    } else {
      map = {
        'title': title,
        'description': description,
      };
    }
    await _instance.collection(userId).doc(id).update(map);
  }

  @override
  Stream<List<Receipt>> stream(String userId) {
    return FirebaseFirestore.instance.collection(userId).snapshots().asyncMap(
          (event) =>
              event.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
            final data = doc.data();
            return Receipt.fromMap(data);
          }).toList(),
        );
  }
}
