import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'receipts_event.dart';
part 'receipts_state.dart';

class ReceiptsBloc extends Bloc<ReceiptsEvent, ReceiptsState> {
  ReceiptsBloc() : super(ReceiptsInitial()) {
    on<ReceiptsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
