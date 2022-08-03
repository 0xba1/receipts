import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

/// Preview an image and click to open file
class ImagePreview extends StatelessWidget {
  /// Preview an image and click to open file
  const ImagePreview({Key? key, required this.path, required this.image})
      : super(key: key);

  /// Path of file to be open
  final String? path;

  /// Image of preview
  final ui.Image? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surface,
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
      ),
    );
  }
}
