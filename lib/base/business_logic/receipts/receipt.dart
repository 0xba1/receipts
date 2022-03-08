import 'package:receipts/base/business_logic/receipts/receipt_file.dart';
import 'package:receipts/base/business_logic/receipts/receipt_file_source.dart';
import 'package:uuid/uuid.dart';

///
abstract class Receipt {
  /// Get uuid (v4) of `Receipt`
  String get id;

  /// Get title of `Receipt`
  String get title;

  /// Get description of `Receipt`
  String get description;

  /// Information about where and how to get `ReceiptFile`
  ReceiptFileSource get receiptFileSource;

  /// Receipt file
  ReceiptFile? get receiptFile;
}

/// `PdfReceipt` subclass of `Receipt`
class PdfReceipt extends Receipt {
  /// `PdfReceipt` constructor
  PdfReceipt({
    required String description,
    required String title,
    required ReceiptFileSource receiptFileSource,
    PdfReceiptFile? receiptFile,
    required String id,
  })  : _description = description,
        _receiptFileSource = receiptFileSource,
        _title = title,
        _id = id,
        _receiptFile = receiptFile;

  final String _description;
  PdfReceiptFile? _receiptFile;
  final ReceiptFileSource _receiptFileSource;
  final String _title;
  final String _id;

  @override
  String get description => _description;

  @override
  PdfReceiptFile? get receiptFile => _receiptFile;

  set receiptFile(PdfReceiptFile? file) {
    _receiptFile = file;
  }

  @override
  ReceiptFileSource get receiptFileSource => _receiptFileSource;

  @override
  String get title => _title;

  @override
  String get id => _id;
}

/// `ImageReceipt` subclass of `Receipt`
class ImageReceipt extends Receipt {
  /// `ImageReceipt` constructor
  ImageReceipt({
    required final String description,
    required final String title,
    required final ReceiptFileSource receiptFileSource,
    ImageReceiptFile? receiptFile,
    String? id,
  }) {
    _id = id ?? const Uuid().v4();
    _description = description;
    _title = title;
    _receiptFile = receiptFile;
    _receiptFileSource = receiptFileSource;
  }
  late String _description;
  ImageReceiptFile? _receiptFile;
  late ReceiptFileSource _receiptFileSource;
  late String _title;
  late String _id;

  @override
  String get description => _description;

  @override
  ImageReceiptFile? get receiptFile => _receiptFile;

  @override
  ReceiptFileSource get receiptFileSource => _receiptFileSource;

  @override
  String get title => _title;

  @override
  String get id => _id;
}
