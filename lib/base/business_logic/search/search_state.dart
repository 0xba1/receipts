part of 'search_cubit.dart';

/// {@template search_state}
/// State of `SearchCubit` containing [List<Receipt>?]
/// {@end_template}
class SearchState extends Equatable {
  /// {@macro search_state}
  const SearchState(this.receipts);

  /// Receipts from database, null if loading
  final List<Receipt> receipts;

  @override
  List<Object> get props => [receipts];
}
