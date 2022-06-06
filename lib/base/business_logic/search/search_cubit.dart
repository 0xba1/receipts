import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:receipts/base/business_logic/database/models/model.dart';
import 'package:receipts/base/business_logic/receipts/receipts_bloc/receipts_bloc.dart';

part 'search_state.dart';

/// {@template search_cubit}
///
/// {@end_template}
class SearchCubit extends Cubit<SearchState> {
  /// {@macro search_cubit}
  SearchCubit(ReceiptsBloc receiptsBloc)
      : _receiptsBloc = receiptsBloc,
        super(const SearchState([]));

  final ReceiptsBloc _receiptsBloc;

  /// Searches the database for query string
  void search(String query) {
    final receipts = _receiptsBloc.state.receipts
        ?.where(
          (Receipt receipt) =>
              receipt.title.contains(query) ||
              receipt.description.contains(query),
        )
        .toList();

    emit(SearchState(receipts));
  }
}
