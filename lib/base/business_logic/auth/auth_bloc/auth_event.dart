part of 'auth_bloc.dart';

///
abstract class AuthEvent extends Equatable {
  ///
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// When user attempts to log out
class AuthLogOutRequested extends AuthEvent {}

/// When user attempts to log in with google
class AuthLogInWithGoogle extends AuthEvent {}

/// When user attempts to log in with email and password
class AuthLogInWithEmail extends AuthEvent {
  /// When user attempts to log in with email and password
  const AuthLogInWithEmail({
    required this.email,
    required this.password,
  });

  /// LogIn email
  final String email;

  /// LogIn password
  final String password;
}

/// When user attempts to sign up with email and password
class AuthSignUpWithEmail extends AuthEvent {
  /// When user attempts to sign up with email and password
  const AuthSignUpWithEmail({
    required this.email,
    required this.password,
  });

  /// SignUp email
  final String email;

  /// SignUp password
  final String password;
}

///
class AuthUserChanged extends AuthEvent {
  ///
  @visibleForTesting
  const AuthUserChanged(this.user);

  ///
  final User user;

  @override
  List<Object?> get props => [user];
}
