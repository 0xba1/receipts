import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:printing/printing.dart';
import 'package:receipts/base/business_logic/database/models/model.dart';
import 'package:receipts/base/business_logic/receipts/receipts_bloc/receipts_bloc.dart';
import 'package:receipts/base/business_logic/storage/storage.dart';

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
                        child: _EditDialog(
                          title: widget._receipt.title,
                          description: widget._receipt.description,
                        ),
                      );
                    },
                  );
                  break;
                case _PopupOption.delete:
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
                  final receiptsBloc = context.read<ReceiptsBloc>();

                  receiptsBloc.add(ReceiptsDelete(widget._receipt.id));

                  await Future<void>.delayed(const Duration(milliseconds: 500));

                  if (mounted) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }

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
              child: _ImagePreview(path: path, image: image),
            )
          ],
        ),
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({Key? key, required this.path, required this.image})
      : super(key: key);

  final String? path;
  final ui.Image? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: double.infinity,
            minHeight: 200,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            child: Opacity(
              opacity: 0.8,
              child: image == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : RawImage(
                      image: image,
                      fit: BoxFit.fitWidth,
                    ),
            ),
            onTap: () {
              if (path != null) {
                OpenFile.open(path);
              }
            },
          ),
        ),
      ),
    );
  }
}

class _EditDialog extends StatefulWidget {
  const _EditDialog({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title;
  final String description;

  @override
  State<_EditDialog> createState() => __EditDialogState();
}

class __EditDialogState extends State<_EditDialog> {
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    titleController.text = widget.title;
    descriptionController = TextEditingController();
    descriptionController.text = widget.description;
  }

  bool isLoading = false;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 280,
        maxWidth: 560,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Edit Receipt',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.titleR,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                  minLines: 1,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.descriptionR,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextButton(
                        onPressed: () {
                          final title = titleController.text;
                          final description = descriptionController.text;
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _PopupOption {
  edit,
  delete,
}
