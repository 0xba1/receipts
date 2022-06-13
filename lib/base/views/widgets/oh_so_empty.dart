import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

/// {@template empty}
/// Meant to show when there are no receipts
/// {@end_template}
class OhSoEmpty extends StatelessWidget {
  /// {@macro empty}
  const OhSoEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lightbulb,
          size: 128,
          color: IconTheme.of(context).color?.withOpacity(0.2),
        ),
        Text(AppLocalizations.of(context)!.ohSoEmpty),
        TextButton(
          onPressed: () {
            context.pushNamed('new_receipt');
          },
          child: Text(AppLocalizations.of(context)!.createNewReceipt),
        ),
      ],
    );
  }
}
