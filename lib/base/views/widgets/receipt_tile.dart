import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts/base/business_logic/database/models/model.dart';

/// {@template receipt_tile}
/// An inkwell on the home screen that leads to `ReceiptDetails`
/// {@endtemplate}
class ReceiptTile extends StatelessWidget {
  /// {@macro receipt_tile}
  const ReceiptTile({Key? key, required this.receipt}) : super(key: key);

  // ignore: public_member_api_docs
  final Receipt receipt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          context.push('/receipt_details', extra: receipt);
        },
        child: Text(receipt.title),
      ),
    );
  }
}
