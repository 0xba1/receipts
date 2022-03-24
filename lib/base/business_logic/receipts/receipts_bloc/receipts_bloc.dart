import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receipts/base/business_logic/auth/auth_repo.dart';
import 'package:receipts/base/business_logic/auth/models/model.dart';
import 'package:receipts/base/business_logic/receipts/receipt.dart';
import 'package:receipts/base/business_logic/receipts/receipt_file.dart';
import 'package:receipts/base/business_logic/receipts/receipt_file_source.dart';

part 'receipts_event.dart';
part 'receipts_state.dart';

///
class ReceiptsBloc extends Bloc<ReceiptsEvent, ReceiptsState> {
  ///
  ReceiptsBloc({required AuthenticationRepository authenticationRepository})
      : super(const ReceiptsState()) {
    on<ReceiptsCreate>(_onReceiptsCreate);
    on<ReceiptsUpdate>(_onReceiptsUpdate);
    on<ReceiptsDelete>(_onReceiptsDelete);
    on<ReceiptsUserChanged>(_onUserChanged);
    on<ReceiptsChanged>(_onReceiptsChanged);

    _userSubscription = authenticationRepository.user.listen(
      (User user) => add(
        ReceiptsUserChanged(userId: user.id),
      ),
    );
  }

  StreamSubscription? _userSubscription;
  StreamSubscription? _receiptSubscription;

  void _onUserChanged(ReceiptsUserChanged event, Emitter emit) {
    _receiptSubscription?.cancel();
    // TODO: Subscribe to receipts (add(ReceiptsChanged(receipts)))
  }

  void _onReceiptsChanged(ReceiptsChanged event, Emitter emit) {
    emit(ReceiptsState(event.receipts));
  }

  void _onReceiptsCreate(ReceiptsCreate event, Emitter emit) {
    // TODO: add receipt to receipts
  }

  void _onReceiptsUpdate(ReceiptsUpdate event, Emitter emit) {
    // TODO: update receipt
  }

  void _onReceiptsDelete(ReceiptsDelete event, Emitter emit) {
    // TODO: update receipt
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    _receiptSubscription?.cancel();
    return super.close();
  }
}
