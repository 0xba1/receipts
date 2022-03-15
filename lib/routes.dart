import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts/base/business_logic/auth/auth_bloc/auth_bloc.dart';
import 'package:receipts/base/views/screens/login.dart';
import 'package:receipts/base/views/screens/signup.dart';

/// Navigations
class Routes {
  /// Navigation handler: GoRouter
  static GoRouter router(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return GoRouter(
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      redirect: (GoRouterState state) {
        // Whether user is logged in
        final isLoggedIn = authBloc.state.status == AuthStatus.authenticated;
        // Whether user is navigating to log in screen
        final isGoingToLogInScreen = state.location == '/login';
        // Whether user is navigating to sign up screen
        final isGoingToSignUpScreen = state.location == '/signup';

        if (!isLoggedIn && !(isGoingToSignUpScreen || isGoingToLogInScreen)) {
          return '/login';
        } else if (isLoggedIn &&
            (isGoingToSignUpScreen || isGoingToLogInScreen)) {
          return '/';
        } else {
          return null;
        }
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage(
            key: state.pageKey,
            child: const Scaffold(),
          ),
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage(
            key: state.pageKey,
            child: const LogInScreen(),
          ),
        ),
        GoRoute(
          path: '/signup',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage(
            key: state.pageKey,
            child: const SignUpScreen(),
          ),
        ),
      ],
    );
  }
}
