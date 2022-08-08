import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts/base/business_logic/auth/auth_bloc/auth_bloc.dart';
import 'package:receipts/base/business_logic/receipts/receipts_bloc/receipts_bloc.dart';
import 'package:receipts/base/views/widgets/confirm_dialog.dart';
import 'package:receipts/base/views/widgets/oh_so_empty.dart';
import 'package:receipts/base/views/widgets/receipt_tile.dart';
import 'package:receipts/base/views/widgets/search_bar.dart';

/// {@template home}
/// Home screen
/// {@endtemplate}
class Home extends StatelessWidget {
  /// {@macro home}
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final receiptsBloc = context.watch<ReceiptsBloc>();
    final authBloc = context.read<AuthBloc>();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (_) => ConfirmDialog(
                        confirm: () {
                          authBloc.add(AuthLogOutRequested());
                        },
                        title: '${AppLocalizations.of(context)!.logout}?',
                        details: AppLocalizations.of(context)!.logoutD,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  label: Text(
                    AppLocalizations.of(context)!.logout,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (_) => ConfirmDialog(
                        confirm: () {
                          authBloc.add(
                            AuthDeleteAccount(context.read<ReceiptsBloc>()),
                          );
                        },
                        title: '${AppLocalizations.of(context)!.deleteA}?',
                        details: AppLocalizations.of(context)!.deleteAD,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  label: Text(
                    AppLocalizations.of(context)!.deleteA,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            const SearchBar(),
            if (receiptsBloc.state.receipts == null)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (receiptsBloc.state.receipts!.isEmpty)
              const Expanded(child: Center(child: OhSoEmpty())),
            if (receiptsBloc.state.receipts != null &&
                receiptsBloc.state.receipts!.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ReceiptTile(
                      receipt: receiptsBloc.state.receipts![index],
                    );
                  },
                  itemCount: receiptsBloc.state.receipts!.length,
                ),
              ),
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
