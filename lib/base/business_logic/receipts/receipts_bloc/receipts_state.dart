part of 'receipts_bloc.dart';

@immutable
class ReceiptsState extends Equatable {
  const ReceiptsState([this.receipts]);

  final List<Receipt>? receipts;

  @override
  List<Object?> get props => [receipts];
}
