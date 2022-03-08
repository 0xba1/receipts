/// Receipt File, could be image, pdf;
/// any file type that contains the receipt details
abstract class ReceiptFile {
  /// File type of receipt
  ReceiptFileType get receiptFileType;
}

///
enum ReceiptFileType {
  ///
  image,

  ///
  pdf,
}

/// Subclass of `ReceiptFile`
class PdfReceiptFile extends ReceiptFile {
  @override
  ReceiptFileType get receiptFileType => ReceiptFileType.pdf;
}

/// Subclass of `ReceiptFile`
class ImageReceiptFile extends ReceiptFile {
  @override
  ReceiptFileType get receiptFileType => ReceiptFileType.image;
}
