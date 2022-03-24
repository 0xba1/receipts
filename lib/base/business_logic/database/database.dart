import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:receipts/base/business_logic/database/models/model.dart';
import 'package:receipts/base/business_logic/storage/storage.dart';
import 'package:uuid/uuid.dart';

/// Interface for remote database
abstract class Database {
  Future<void> createReceipt({
    required String userId,
    required String title,
    required String description,
    required String filePath,
  });

  Future<void> updateReceipt({
    required String id,
    required String userId,
    String? title,
    String? description,
    String? filePath,
  });

  Future<void> deleteReceipt({
    required String id,
    required String userId,
  });

  Stream<List<Receipt>> get stream;
}

class FireDatabase extends Database {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final FireStorage _storage = FireStorage();
  final _uuid = const Uuid();

  @override
  Future<void> createReceipt({
    required String userId,
    required String title,
    required String description,
    required String filePath,
  }) async {
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
    String? filePath,
  }) async {
    final map = {
      'title': title,
      'description': description,
      'file_path': filePath,
    };
    await _instance.collection(userId).doc(id).update(map);
  }

  @override
  Stream<List<Receipt>> get stream {
    return FirebaseFirestore.instance.collection('users').snapshots().asyncMap(
          (event) =>
              event.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
            final data = doc.data();
            return Receipt.fromMap(data);
          }).toList(),
        );
  }
}
