import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// {@template new_receipt}
/// Create new receipt
/// {@endtemplate}
class NewReceipt extends StatefulWidget {
  /// {@macro new_receipt}
  const NewReceipt({Key? key}) : super(key: key);

  @override
  State<NewReceipt> createState() => _NewReceiptState();
}

class _NewReceiptState extends State<NewReceipt> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: const Text('Create New Receipt'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      minLines: 6,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        final pickedFilePath = await _pickFilePath();
                        if (pickedFilePath == null) return;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Upload Receipt file (*.pdf, *.jpg, *.png,)',
                          ),
                          Icon(Icons.file_open)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          Size(width - 16, 48),
                        ),
                      ),
                      child: const Text('Create Receipt'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> _pickFilePath() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: [
      'jpg',
      'png',
      'pdf',
    ],
  );

  return result?.files.single.path;
}
