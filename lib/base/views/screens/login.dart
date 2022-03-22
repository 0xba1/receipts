import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts/base/business_logic/auth/auth_bloc/auth_bloc.dart';
import 'package:receipts/keys.dart';
import 'package:receipts/logo.dart';

/// {@template login}
/// Login Screen
/// {@endtemplate}
class LogInScreen extends StatefulWidget {
  /// {@macro login}
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool obscurePassword = true;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Logo(),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: Keys.logInFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 5,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        labelText: AppLocalizations.of(context)!.email,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 5,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        labelText: AppLocalizations.of(context)!.password,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  authBloc.add(
                    AuthLogInWithEmail(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size(width - 16, 48),
                  ),
                ),
                child: Text(AppLocalizations.of(context)!.logInWithEmail),
              ),
            ),
            const SizedBox(height: 64),
            ElevatedButton(
              onPressed: () {
                authBloc.add(AuthLogInWithGoogle());
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(width - 16, 48),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: Text(AppLocalizations.of(context)!.logInWithGoogle),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.goNamed('signup');
              },
              // child: Text(AppLocalizations.of(context)!.dontHaveAccount),
              child: const Text(
                "Don't have account? Create new account",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
