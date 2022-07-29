import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receipts/base/business_logic/auth/auth_repo.dart';
import 'package:receipts/base/business_logic/auth/models/model.dart';
import 'package:receipts/base/business_logic/database/database.dart';
import 'package:receipts/base/business_logic/database/models/model.dart';

part 'receipts_event.dart';
part 'receipts_state.dart';

///
class ReceiptsBloc extends Bloc<ReceiptsEvent, ReceiptsState> {
  ///
  ReceiptsBloc({
    required AuthenticationRepository authenticationRepository,
    required FireDatabase database,
  }) : super(const ReceiptsState()) {
    on<ReceiptsUpdate>(_onReceiptsUpdate);
    on<ReceiptsDelete>(_onReceiptsDelete);
    on<ReceiptsUserChanged>(_onUserChanged);
    on<ReceiptsChanged>(_onReceiptsChanged);

    _fireDatabase = database;
    _userSubscription = authenticationRepository.user.listen(
      (User user) {
        _userId = user.id;

        add(
          ReceiptsUserChanged(userId: user.id),
        );
      },
    );
    _receiptSubscription = _fireDatabase
        .stream(authenticationRepository.currentUser.id)
        .listen((List<Receipt> receipts) {
      add(
        ReceiptsChanged(receipts: receipts),
      );
    });
  }
  late final FireDatabase _fireDatabase;
  StreamSubscription? _userSubscription;
  StreamSubscription? _receiptSubscription;
  late String _userId;

  void _onUserChanged(ReceiptsUserChanged event, Emitter emit) {
    _receiptSubscription?.cancel();
    if (event.userId != '') {
      _receiptSubscription = _fireDatabase.stream(event.userId).listen(
            (receipts) => add(
              ReceiptsChanged(receipts: receipts),
            ),
          );
    }
  }

  // emits new state
  void _onReceiptsChanged(ReceiptsChanged event, Emitter emit) {
    emit(ReceiptsState(event.receipts));
  }

  Future<void> createReceipt({
    required String title,
    required String description,
    required String localFilePath,
  }) async {
    await _fireDatabase.createReceipt(
      userId: _userId,
      title: title,
      description: description,
      localFilePath: localFilePath,
    );
  }

  void _onReceiptsUpdate(ReceiptsUpdate event, Emitter emit) {
    unawaited(
      _fireDatabase.updateReceipt(
        userId: _userId,
        id: event.id,
        title: event.title,
        description: event.description,
        localFilePath: event.localFilePath,
      ),
    );
  }

  void _onReceiptsDelete(ReceiptsDelete event, Emitter emit) {
    unawaited(
      _fireDatabase.deleteReceipt(
        userId: _userId,
        id: event.id,
      ),
    );
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    _receiptSubscription?.cancel();
    return super.close();
  }
}
