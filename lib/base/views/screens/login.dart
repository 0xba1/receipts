import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:receipts/base/business_logic/auth/auth_bloc/auth_bloc.dart';
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
    final logInFormKey = GlobalKey<FormState>();
    return Scaffold(
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: logInFormKey,
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
                          hintText: AppLocalizations.of(context)!.email,
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          hintText: AppLocalizations.of(context)!.password,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          authBloc.add(
                            AuthLogInWithEmail(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        },
                        child:
                            Text(AppLocalizations.of(context)!.logInWithEmail),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                authBloc.add(AuthLogInWithGoogle());
              },
              child: Text(AppLocalizations.of(context)!.logInWithGoogle),
            ),
          ],
        ),
      ),
    );
  }
}
