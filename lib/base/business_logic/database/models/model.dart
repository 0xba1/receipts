/// Model for receipt
class Receipt {
  /// Constructor for [Receipt]
  Receipt({
    required this.title,
    required this.description,
    required this.fileType,
    required this.storePath,
    required this.id,
    required this.userId,
  });

  /// Creates a [Receipt] from [Map<String, dynamic>]
  Receipt.fromMap(Map<String, dynamic> map)
      : title = map['title'] as String,
        description = map['description'] as String,
        fileType = FileTypeHelper.fromStr(map['file-type'] as String),
        storePath = map['store_path'] as String,
        id = map['id'] as String,
        userId = map['user_id'] as String;

  /// Title of the receipt
  String title;

  /// Description of the receipt
  String description;

  /// [FileType] of the receipt
  FileType fileType;

  /// Storage path
  String storePath;

  /// [Receipt] id
  String id;

  /// [Receipt] `User` id
  String userId;
}

/// Enum indicating file type
enum FileType {
  /// Image file type
  jpg,

  /// Image file type
  png,

  /// Pdf file type
  pdf,

  /// No file
  none,
}

///
extension Str on FileType {
  ///
  String toStr() {
    switch (this) {
      case FileType.jpg:
        return 'jpg';
      case FileType.png:
        return 'png';
      case FileType.pdf:
        return 'pdf';
      case FileType.none:
        return 'none';
    }
  }
}

/// Factory for FileType
class FileTypeHelper {
  ///
  static FileType fromStr(String str) {
    switch (str) {
      case 'jpg':
        return FileType.jpg;
      case 'png':
        return FileType.png;
      case 'pdf':
        return FileType.pdf;
      default:
        return FileType.none;
    }
  }
}
