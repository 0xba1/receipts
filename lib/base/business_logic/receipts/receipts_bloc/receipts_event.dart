part of 'receipts_bloc.dart';

///
@immutable
abstract class ReceiptsEvent extends Equatable {}

///
class ReceiptsCreate extends ReceiptsEvent {
  ///
  ReceiptsCreate({
    required this.userId,
    required this.title,
    required this.description,
    required this.localFilePath,
  });

  ///
  final String userId;

  ///
  final String title;

  ///
  final String description;

  ///
  final String localFilePath;

  @override
  List<Object?> get props => [
        userId,
        title,
        description,
        localFilePath,
      ];
}

///
class ReceiptsUpdate extends ReceiptsEvent {
  ///
  ReceiptsUpdate({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.localFilePath,
  });

  ///
  final String userId;

  ///
  final String id;

  ///
  final String title;

  ///
  final String? description;

  ///
  final String? localFilePath;

  @override
  List<Object?> get props => [
        userId,
        id,
        title,
        description,
        localFilePath,
      ];
}

///
class ReceiptsDelete extends ReceiptsEvent {
  ///
  ReceiptsDelete(this.userId, this.id);

  ///
  final String userId;

  ///
  final String id;

  @override
  List<Object?> get props => [userId, id];
}

///
class ReceiptsUserChanged extends ReceiptsEvent {
  ///
  ReceiptsUserChanged({
    required this.userId,
  });

  ///
  final String userId;

  @override
  List<Object?> get props => [userId];
}

///
class ReceiptsChanged extends ReceiptsEvent {
  ///
  ReceiptsChanged({
    required this.receipts,
  });

  ///
  final List<Receipt>? receipts;

  ///
  @override
  List<Object?> get props => [receipts];
}
