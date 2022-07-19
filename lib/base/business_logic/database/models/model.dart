/// Model for receipt
class Receipt {
  /// Constructor for [Receipt]
  Receipt({
    required this.title,
    required this.description,
    required this.fileType,
    required this.filePath,
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  /// Creates a [Receipt] from [Map<String, dynamic>]
  Receipt.fromMap(Map<String, dynamic> map)
      : title = map['title'] as String,
        description = map['description'] as String,
        fileType = FileTypeHelper.fromStr(map['file_type'] as String?),
        filePath = map['file_path'] as String,
        id = map['id'] as String,
        createdAt = map['created_at'] as int,
        lastUpdatedAt = map['last_updated_at'] as int,
        userId = map['user_id'] as String;

  /// Title of the receipt
  final String title;

  /// Time receipt was created in milliseconds from epoch
  final int createdAt;

  /// Time receipt was last updated in milliseconds from epoch
  final int lastUpdatedAt;

  /// Description of the receipt
  final String description;

  /// [FileType] of the receipt
  final FileType fileType;

  /// Storage path
  final String filePath;

  /// [Receipt] id
  final String id;

  /// [Receipt] `User` id
  final String userId;
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
  static FileType fromStr(String? str) {
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
