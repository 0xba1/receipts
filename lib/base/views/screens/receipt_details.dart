import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';
import 'package:receipts/base/business_logic/database/models/model.dart';
import 'package:receipts/base/business_logic/receipts/receipts_bloc/receipts_bloc.dart';
import 'package:receipts/base/business_logic/storage/storage.dart';
import 'package:receipts/base/views/widgets/confirm_dialog.dart';
import 'package:receipts/base/views/widgets/edit_dialog.dart';
import 'package:receipts/base/views/widgets/image_preview.dart';

/// {@template details}
/// Screen showing the details of a receipt also option to open the receipt
/// {@end_template}
class ReceiptDetails extends StatefulWidget {
  /// {@macro details}
  const ReceiptDetails({Key? key, required Receipt receipt})
      : _receipt = receipt,
        super(key: key);

  final Receipt _receipt;

  @override
  State<ReceiptDetails> createState() => _ReceiptDetailsState();
}

class _ReceiptDetailsState extends State<ReceiptDetails> {
  ui.Image? image;
  String? path;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<ui.Image> _firstPageImage(String path) async {
    final pdfDoc = await File(path).readAsBytes();

    final raster = await Printing.raster(pdfDoc).first;

    return raster.toImage();
  }

  Future<String?> _downloadFile() =>
      FireStorage().downloadFile(filePath: widget._receipt.filePath);

  Future<void> _loadImage() async {
    path = await _downloadFile();
    if (path == null) return;

    if (widget._receipt.fileType == FileType.pdf) {
      image = await _firstPageImage(path!);
    } else if (widget._receipt.fileType != FileType.none) {
      image = await _convertFileToImage(path!);
    }

    if (mounted) setState(() {});
  }

  Future<ui.Image> _convertFileToImage(String path) async {
    final bytes = await File(path).readAsBytes();

    return decodeImageFromList(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget._receipt.title,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          PopupMenuButton<_PopupOption>(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (_PopupOption value) async {
              switch (value) {
                case _PopupOption.edit:
                  await showDialog<void>(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        child: EditDialog(
                          title: widget._receipt.title,
                          description: widget._receipt.description,
                          id: widget._receipt.id,
                        ),
                      );
                    },
                  );
                  break;
                case _PopupOption.delete:
                  await showDialog<void>(
                    context: context,
                    builder: (_) => ConfirmDialog(
                      confirm: () async {
                        context
                            .read<ReceiptsBloc>()
                            .add(ReceiptsDelete(widget._receipt.id));

                        unawaited(
                          showDialog<void>(
                            context: context,
                            builder: (_) {
                              return const SizedBox.expand(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
                        );

                        await Future<void>.delayed(
                          const Duration(milliseconds: 500),
                        );

                        if (mounted) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        }
                      },
                      title: AppLocalizations.of(context)!.deleteR,
                      details: AppLocalizations.of(context)!.deleteD,
                    ),
                  );

                  break;
              }
            },
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  value: _PopupOption.edit,
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
                        AppLocalizations.of(context)!.edit,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: _PopupOption.delete,
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
                        AppLocalizations.of(context)!.delete,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      )
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 8, left: 16),
              child: Text(
                AppLocalizations.of(context)!.descriptionR,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 32, bottom: 48),
              child: Text(widget._receipt.description),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 8, left: 16),
              child: Text(
                AppLocalizations.of(context)!.previewR,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ImagePreview(path: path, image: image),
            )
          ],
        ),
      ),
    );
  }
}

enum _PopupOption {
  edit,
  delete,
}
