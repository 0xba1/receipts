import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts/base/business_logic/auth/auth_bloc/auth_bloc.dart';
import 'package:receipts/keys.dart';
import 'package:receipts/logo.dart';
import 'package:receipts/validator.dart';

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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              height: size.height,
              width: size.width,
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
                            validator: (value) {
                              if (!Validator.isEmailValid(value)) {
                                return AppLocalizations.of(context)!
                                    .enterValidEmail;
                              }
                              return null;
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 5,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        if (Keys.logInFormKey.currentState!.validate()) {
                          authBloc.add(
                            AuthLogInWithEmail(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          Size(width - 32, 48),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.logInWithEmail,
                      ),
                    ),
                  ),
                  const SizedBox(height: 64),
                  ElevatedButton(
                    onPressed: () {
                      authBloc.add(AuthLogInWithGoogle());
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(width - 32, 48),
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
                    child: Text(
                      AppLocalizations.of(context)!.dontHaveAccount,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
