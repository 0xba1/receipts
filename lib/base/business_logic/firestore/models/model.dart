/// Model for the receipt
class Receipt {
  /// Constructor
  Receipt({
    required this.title,
    required this.description,
    required this.fileType,
    required this.storePath,
  });

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
