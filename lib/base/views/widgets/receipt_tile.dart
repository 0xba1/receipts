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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(16),
          // ),
          onTap: () {
            context.push('/receipt_details', extra: receipt);
          },
          title: Text(receipt.title),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
            child: Icon(
              receipt.fileType == FileType.pdf
                  ? Icons.picture_as_pdf_rounded
                  : Icons.image,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          subtitle: Text(
            _beautifyDate(receipt.lastUpdatedAt),
          ),
          trailing: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: const Icon(
              Icons.lock_open_rounded,
            ),
          ),
        ),
      ),
    );
  }
}

String _beautifyDate(int millisecondsSinceEpoch) {
  final date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  if (DateTime.now().year == date.year) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}    ${date.day}/${date.month}';
  }

  return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}    ${date.day}/${date.month}/${date.year}';
}
