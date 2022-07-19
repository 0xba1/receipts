import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Abstract interface of remote storage
abstract class Storage {
  /// Receives userId and local file path and returns path of the remote storage
  Future<String?> uploadFile({
    required String userId,
    required String localFilePath,
  });

  /// Returns downloaded file path, arg: path of storage to be downloaded from
  Future<String?> downloadFile({
    required String filePath,
  });

  /// Deletes file from remote database
  Future<void> deleteFile({
    required String userId,
    required String id,
  });
}

/// Firebase Storage
class FireStorage extends Storage {
  final FirebaseStorage _instance = FirebaseStorage.instance;
  final _uuid = const Uuid();

  @override
  Future<String?> uploadFile({
    required String userId,
    required String localFilePath,
  }) async {
    // if (!await Permission.storage.request().isGranted) {
    //   return null;
    // }
    final id = _uuid.v4();
    final file = File(localFilePath);

    try {
      await _instance.ref('$userId/$id').putFile(file);
      return '$userId/$id';
    } on FirebaseException catch (err) {
      debugPrint('**************Failed************');
      debugPrint('Failed to upload file: $err');
    }
    return null;
  }

  @override
  Future<String?> downloadFile({
    required String filePath,
  }) async {
    // if (!await Permission.storage.request().isGranted) {
    //   return null;
    // }
    final appDocDir = await getApplicationDocumentsDirectory();
    final path = '${appDocDir.path}/$filePath';
    final downloadToFile = await File(path).create(recursive: true);

    try {
      await _instance.ref(filePath).writeToFile(downloadToFile);
      return path;
    } on FirebaseException catch (err) {
      debugPrint('Failed to download file: $err');
    }
    return null;
  }

  @override
  Future<void> deleteFile({
    required String userId,
    required String id,
  }) async {
    try {
      await _instance.ref('$userId/$id').delete();
    } on FirebaseException catch (err) {
      debugPrint('Failed to delete file: $err');
    }
  }
}
