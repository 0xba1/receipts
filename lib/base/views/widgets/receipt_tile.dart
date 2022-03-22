import 'package:flutter/material.dart';

/// {@template receipt_tile}
/// An inkwell on the home screen that leads to [ReceiptDetails]
/// {@endtemplate}
class ReceiptTile extends StatelessWidget {
  /// {@macro receipt_tile}
  const ReceiptTile({Key? key, required this.uuid, required this.title})
      : super(key: key);

  // ignore: public_member_api_docs
  final String uuid;
  // ignore: public_member_api_docs
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {},
        child: Text(title),
      ),
    );
  }
}
