import 'package:receipts/base/business_logic/receipts/receipt.dart';

/// A class containing a `List` of `Receipt`s
class Receipts {
  final List<Receipt> _receiptList = [];

  /// `List` of `Receipt`s
  List<Receipt> get list => _receiptList;

  /// Add a `Receipt`
  void addReceipt(Receipt receipt) {
    _receiptList.add(receipt);
  }

  /// Delete a `Receipt`
  void deleteReceipt(String id) {
    _receiptList.removeWhere((Receipt receipt) => receipt.id == id);
  }
}
