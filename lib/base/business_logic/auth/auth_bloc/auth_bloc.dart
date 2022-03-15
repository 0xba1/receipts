import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:receipts/base/business_logic/auth/auth_repo.dart';
import 'package:receipts/base/business_logic/auth/models/model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

///
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ///
  AuthBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthState.authenticated(authenticationRepository.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLogOutRequested>(_onLogOutRequested);
    on<AuthLogInWithGoogle>(_onLogInWithGoogle);
    on<AuthLogInWithEmail>(_onLogInWithEmail);
    on<AuthSignUpWithEmail>(_onSignUpWithEmail);

    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(
        AuthUserChanged(user),
      ),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  void _onLogOutRequested(AuthLogOutRequested event, Emitter<AuthState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  void _onLogInWithGoogle(AuthLogInWithGoogle event, Emitter<AuthState> emit) {
    unawaited(_authenticationRepository.logInWithGoogle());
  }

  void _onLogInWithEmail(AuthLogInWithEmail event, Emitter<AuthState> emit) {
    unawaited(
      _authenticationRepository.logInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      ),
    );
  }

  void _onSignUpWithEmail(AuthSignUpWithEmail event, Emitter<AuthState> emit) {
    unawaited(
      _authenticationRepository.logInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      ),
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
