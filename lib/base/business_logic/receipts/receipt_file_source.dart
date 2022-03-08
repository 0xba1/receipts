import 'package:receipts/base/business_logic/receipts/receipt_file.dart';

/// Any source for the receipt file e.g Firebase Storage
abstract class ReceiptFileSource {
  /// Gets `ReceiptFile` from file source
  Future<ReceiptFile> getReceiptFile();

  /// ReceiptFileSource type
  ReceiptFileSourceType get type;
}

/// An enum indicating where receipt file is got from
enum ReceiptFileSourceType {
  /// Firebase Storage as receipt file source
  firebaseStorage,
}
