import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipts/base/business_logic/receipts/receipts_bloc/receipts_bloc.dart';
import 'package:receipts/base/views/widgets/oh_so_empty.dart';
import 'package:receipts/base/views/widgets/receipt_tile.dart';

/// {@template receipts_view}
/// Scrollable widget consisting of the list of widgets in form of [ReceiptTile]
/// {@end_template receipts_view}
class ReceiptsView extends StatelessWidget {
  /// {@macro receipts_view}
  const ReceiptsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptsBloc, ReceiptsState>(
      builder: (BuildContext context, ReceiptsState state) {
        if (state.receipts == null) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.receipts!.isEmpty) {
          return const OhSoEmpty();
        } else {
          return ListView.builder(
            itemCount: state.receipts!.length,
            itemBuilder: (context, index) {
              return ReceiptTile(receipt: state.receipts![index]);
            },
          );
        }
      },
    );
  }
}
