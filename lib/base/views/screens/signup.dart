import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:receipts/base/business_logic/auth/auth_bloc/auth_bloc.dart';
import 'package:receipts/logo.dart';

///
class SignUpScreen extends StatefulWidget {
  ///
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    final signUpFormKey = GlobalKey<FormState>();
    final authBloc = context.read<AuthBloc>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  key: signUpFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 5,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          hintText: AppLocalizations.of(context)!.email,
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 5,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          hintText: AppLocalizations.of(context)!.password,
                        ),
                      ),
                      // Sign up with email and password
                      ElevatedButton(
                        onPressed: () {
                          authBloc.add(
                            AuthSignUpWithEmail(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signUpWithEmail,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    authBloc.add(AuthLogInWithGoogle());
                  },
                  style: ElevatedButtonTheme.of(context).style!.copyWith(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                  child: Text(AppLocalizations.of(context)!.signUpWithGoogle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
