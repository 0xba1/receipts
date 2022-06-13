import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts/base/business_logic/receipts/receipts_bloc/receipts_bloc.dart';
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

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ReceiptTile(
                      receipt: receiptsBloc.state.receipts![index],
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 16,
                  ),
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
