import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:receipts/base/business_logic/database/models/model.dart';
import 'package:receipts/base/business_logic/storage/storage.dart';

/// {@template details}
/// Screen showing the details of a receipt also option to open the receipt
/// {@end_template}
class ReceiptDetails extends StatelessWidget {
  /// {@macro details}
  const ReceiptDetails({Key? key, required Receipt receipt})
      : _receipt = receipt,
        super(key: key);

  final Receipt _receipt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.pop(),
        ),
        title: Text(
          _receipt.title,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_rounded),
            itemBuilder: (_) {
              return [
                PopupMenuItem<void>(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                  onTap: () {},
                ),
                PopupMenuItem<void>(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.delete_rounded,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      )
                    ],
                  ),
                  onTap: () {},
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(_receipt.description),
          InkWell(
            onTap: () async {
              final filePath =
                  await FireStorage().downloadFile(filePath: _receipt.filePath);
              if (filePath != null) {
                await OpenFile.open(filePath);
              }
            },
            radius: 10,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: const [
                  Expanded(
                    child: Icon(
                      Icons.file_open_rounded,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text('Open receippt'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _PopupOptions {
  edit,
  delete,
}
