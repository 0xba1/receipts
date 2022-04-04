import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts/base/views/widgets/search_bar.dart';

/// {@template home}
/// Home screen
/// {@endtemplate}
class Home extends StatelessWidget {
  /// {@macro home}
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [
            SearchBar(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: AppLocalizations.of(context)!.createNewReceipt,
          onPressed: () {
            context.pushNamed('new_receipt');
          },
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
