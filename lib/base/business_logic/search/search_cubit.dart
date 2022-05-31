import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:receipts/base/business_logic/database/database.dart';
import 'package:receipts/base/business_logic/database/models/model.dart';

part 'search_state.dart';

/// {@template search_cubit}
///
/// {@end_template}
class SearchCubit extends Cubit<SearchState> {
  /// {@macro search_cubit}
  SearchCubit(FireDatabase database)
      : _database = database,
        super(const SearchState());

  final FireDatabase _database;

  /// Searches the database for query string
  void search(String query) {}
}
