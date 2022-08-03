import 'package:flutter/material.dart';

/// [Dialog] for action confirmation
class ConfirmDialog extends StatelessWidget {
  /// [Dialog] for action confirmation
  const ConfirmDialog({
    super.key,
    required this.confirm,
    required this.title,
    required this.details,
  });

  /// Closure to be run if user clicks 'confirm'
  final void Function() confirm;

  /// Title of dialog
  final String title;

  /// Body of dialog
  final String details;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 280,
          maxWidth: 560,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: 8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    details,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
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
                          onPressed: confirm,
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
      ),
    );
  }
}
