import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:printing/printing.dart';
import 'package:receipts/base/business_logic/database/models/model.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 32, bottom: 8, left: 16),
              child: Text('Description'),
            ),
            const Divider(
              indent: 16,
              endIndent: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 32, bottom: 48),
              child: Text(widget._receipt.description),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 32, bottom: 8, left: 16),
              child: Text('Preview'),
            ),
            const Divider(
              indent: 16,
              endIndent: 16,
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
