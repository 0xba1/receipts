import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receipts/base/business_logic/receipts/receipts_bloc/receipts_bloc.dart';
import 'package:receipts/keys.dart';
import 'package:receipts/validator.dart';

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
  String? localFilePath;

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
    final receiptsBloc = context.read<ReceiptsBloc>();

    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => context.pop(),
          ),
          title: Text(AppLocalizations.of(context)!.createNewReceipt),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Form(
                key: Keys.receiptFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (Validator.isStringValid(value)) {
                          return null;
                        }
                        return AppLocalizations.of(context)!.enterValidText;
                      },
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.titleR,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (Validator.isStringValid(value)) {
                          return null;
                        }
                        return AppLocalizations.of(context)!.enterValidText;
                      },
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      minLines: 6,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.descriptionR,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        // final pickedFilePath = await _pickFilePath();
                        // if (pickedFilePath == null) return;
                        localFilePath = await _getFileFromModal(context);
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
                      onPressed: () async {
                        if (Keys.receiptFormKey.currentState!.validate() &&
                            localFilePath != null) {
                          await receiptsBloc.createReceipt(
                            title: titleController.text,
                            description: descriptionController.text,
                            localFilePath: localFilePath!,
                          );
                          // ignore: use_build_context_synchronously
                          context.go('/');
                        } else {
                          debugPrint(
                            '${Keys.receiptFormKey.currentState!.validate()} ********* $localFilePath',
                          );
                        }
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          Size(width - 16, 48),
                        ),
                      ),
                      child: Text(AppLocalizations.of(context)!.createReceipt),
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
  debugPrint('File path: ${result?.files.single.path}');
  return result?.files.single.path;
}

Future<String?> _takePicture() async {
  final _picker = ImagePicker();
  final pic = await _picker.pickImage(source: ImageSource.camera);
  return pic?.path;
}

Future<String?> _getFileFromModal(BuildContext context) async {
  final width = MediaQuery.of(context).size.width;
  String? pathOfChosenFile;
  await showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext ctx) {
      return SizedBox(
        height: 176,
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(width - 16, 48),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.tertiary,
                ),
              ),
              onPressed: () async {
                pathOfChosenFile = await _takePicture();
                // ignore: use_build_context_synchronously
                Navigator.pop(ctx);
              },
              label: Text(AppLocalizations.of(context)!.takePicture),
              icon: const Icon(Icons.camera_rounded),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(width - 16, 48),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.tertiary,
                ),
              ),
              onPressed: () async {
                pathOfChosenFile = await _pickFilePath();
                // ignore: use_build_context_synchronously
                Navigator.pop(ctx);
              },
              label: Text(AppLocalizations.of(context)!.fileFromDevice),
              icon: const Icon(Icons.file_open_rounded),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      );
    },
  );
  debugPrint('File from modal: $pathOfChosenFile');
  return pathOfChosenFile;
}
