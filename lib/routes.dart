import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts/base/business_logic/auth/auth_bloc/auth_bloc.dart';
import 'package:receipts/base/business_logic/database/models/model.dart';
import 'package:receipts/base/views/screens/home.dart';
import 'package:receipts/base/views/screens/login.dart';
import 'package:receipts/base/views/screens/new_receipt.dart';
import 'package:receipts/base/views/screens/receipt_details.dart';
import 'package:receipts/base/views/screens/search_screen.dart';
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
          name: 'home',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage(
            key: state.pageKey,
            child: const Home(),
          ),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage(
            key: state.pageKey,
            child: const LogInScreen(),
          ),
        ),
        GoRoute(
          path: '/signup',
          name: 'signup',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage(
            key: state.pageKey,
            child: const SignUpScreen(),
          ),
        ),
        GoRoute(
          path: '/search',
          name: 'search',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage(
            key: state.pageKey,
            child: const SearchScreen(),
          ),
        ),
        GoRoute(
          path: '/new_receipt',
          name: 'new_receipt',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage(
            key: state.pageKey,
            child: const NewReceipt(),
          ),
        ),
        GoRoute(
          path: '/receipt_details',
          name: 'receipt_details',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              MaterialPage(
            key: state.pageKey,
            child: ReceiptDetails(
              receipt: state.extra! as Receipt,
            ),
          ),
        ),
      ],
    );
  }
}
