/// Model for the receipt
class Receipt {
  /// Constructor
  Receipt({
    required this.title,
    required this.description,
    required this.fileType,
    required this.storePath,
  });

  Receipt.fromMap(Map<String, dynamic> map)
      : title = map['title'] as String,
        description = map['description'] as String,
        fileType = map['file_type'] as FileType,
        storePath = map['store_path'] as String;

  /// Title of the receipt
  String title;

  /// Description of the receipt
  String description;

  /// [FileType] of the receipt
  FileType fileType;

  /// Firebase Storage path
  String storePath;
}

/// Enum indicating file type
enum FileType {
  /// Image file type
  image,

  /// Pdf file type
  pdf,

  /// No file
  none,
}
