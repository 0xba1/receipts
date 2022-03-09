import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

/// {@template logo}
/// Logo of the app: "Receipts" in Lobster font
/// {@endtemplate}
class Logo extends StatelessWidget {
  /// {@macro logo}
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.title,
      style: GoogleFonts.lobster(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
