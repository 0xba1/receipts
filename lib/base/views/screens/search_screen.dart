import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts/base/business_logic/search/search_cubit.dart';
import 'package:receipts/base/views/widgets/oh_so_empty.dart';
import 'package:receipts/base/views/widgets/receipt_tile.dart';

/// {@template search_screen}
/// Screen to search firebase database
/// {@end_template}
class SearchScreen extends StatelessWidget {
  /// {@macro search_screen}
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.watch<SearchCubit>();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                ),
              ),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.search,
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  prefixIcon: BackButton(
                    onPressed: () => context.pop(),
                  ),
                ),
                onChanged: searchCubit.search,
              ),
            ),
            if (searchCubit.state.receipts == null)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            if (searchCubit.state.receipts!.isEmpty)
              const Expanded(child: Center(child: OhSoEmpty())),
            if (searchCubit.state.receipts != null &&
                searchCubit.state.receipts!.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ReceiptTile(
                      receipt: searchCubit.state.receipts![index],
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: searchCubit.state.receipts!.length,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
