part of 'receipts_bloc.dart';

/// {@template receipts_state}
/// State of [ReceiptsBloc] containing [List<Receipt>?]
/// {@end_template receipts_state}
@immutable
class ReceiptsState extends Equatable {
  /// {@macro receipts_state}
  const ReceiptsState([this.receipts]);

  ///
  final List<Receipt>? receipts;

  @override
  List<Object?> get props => [receipts];
}
