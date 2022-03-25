part of 'auth_bloc.dart';

/// Authentication status
enum AuthStatus {
  /// User is authenticated
  authenticated,
  /// User is not authenticated
  unauthenticated,
}

/// {@template auth_state}
/// State of [AuthBloc]
/// {@endtemplate}
class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.user = User.empty,
  });

  /// {@macro auth_state} authenticated
  const AuthState.authenticated(User user)
      : this._(status: AuthStatus.authenticated, user: user);

  /// {@macro auth_state} unauthenticated
  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  /// [AuthStatus] : authenticated, unauthenticated
  final AuthStatus status;

  /// [User]
  final User user;

  @override
  List<Object?> get props => [status, user];
}
