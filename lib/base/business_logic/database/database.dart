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
    final currentTime = DateTime.now().microsecondsSinceEpoch;
    final fileType = extractExt(localFilePath);
    final filePath =
        await _storage.uploadFile(userId: userId, localFilePath: localFilePath);
    final id = _uuid.v4();
    final map = {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'file_path': filePath,
      'file_type': fileType,
      'encrypted': false,
      'created_at': currentTime,
      'last_updated_at': currentTime,
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
    final currentTime = DateTime.now().microsecondsSinceEpoch;

    final Map<String, Object?> map;
    if (localFilePath != null) {
      final filePath = await _storage.uploadFile(
        userId: userId,
        localFilePath: localFilePath,
      );
      map = {
        'title': title,
        'description': description,
        'file_path': filePath,
        'last_updated_at': currentTime,
      };
    } else {
      map = {
        'title': title,
        'description': description,
        'last_updated_at': currentTime,
      };
    }
    await _instance.collection(userId).doc(id).update(map);
  }

  @override
  Stream<List<Receipt>> stream(String userId) {
    if (userId == '') return Stream.value([]);

    return _instance.collection(userId).snapshots().asyncMap(
          (event) =>
              event.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
            final data = doc.data();
            return Receipt.fromMap(data);
          }).toList(),
        );
  }

  /// Current list of [Receipt]s
  Future<List<Receipt>> receipts(String userId) async {
    if (userId == '') return [];

    final collection = await _instance.collection(userId).get();

    return collection.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      final data = doc.data();
      return Receipt.fromMap(data);
    }).toList();
  }
}

/// Extracts file extension from string
String? extractExt(String fileName) {
  final pattern = RegExp(r'\.(?<ext>[0-9a-zA-Z]+)$');
  final match = pattern.firstMatch(fileName);
  return match?.namedGroup('ext');
}
