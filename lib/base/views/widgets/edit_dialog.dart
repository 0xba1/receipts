import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts/base/business_logic/receipts/receipts_bloc/receipts_bloc.dart';

/// Dialog for editing receipt
class EditDialog extends StatefulWidget {
  /// Dialog for editing receipt
  const EditDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.id,
  }) : super(key: key);

  /// id of the receipt to be edited
  final String id;

  /// Title of the receipt to be edited
  final String title;

  /// Description of the receipt to be edited
  final String description;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
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
                  AppLocalizations.of(context)!.editR,
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
                          AppLocalizations.of(context)!.cancel,
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
                          context.read<ReceiptsBloc>().add(
                                ReceiptsUpdate(
                                  id: widget.id,
                                  title: title,
                                  description: description,
                                ),
                              );
                          context.pop();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.confirm,
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
