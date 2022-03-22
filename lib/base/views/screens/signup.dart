import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:receipts/base/business_logic/auth/auth_bloc/auth_bloc.dart';
import 'package:receipts/keys.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.primary,
      ),
    );
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
                key: Keys.signUpFormKey,
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
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
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
                child: Text(AppLocalizations.of(context)!.signUpWithEmail),
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
              child: Text(AppLocalizations.of(context)!.signUpWithGoogle),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.goNamed('login');
              },
              // child: Text(AppLocalizations.of(context)!.haveAccount),
              child: const Text(
                'Have an account? Log In',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: SafeArea(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         const SizedBox(
    //           height: 100,
    //         ),
    //         const Logo(),
    //         const SizedBox(
    //           height: 100,
    //         ),
    //         Expanded(
    //           child: Padding(
    //             padding: const EdgeInsets.all(8),
    //             child: Form(
    //               key: signUpFormKey,
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                 children: [
    //                   TextFormField(
    //                     controller: emailController,
    //                     decoration: InputDecoration(
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(10),
    //                         borderSide: BorderSide(
    //                           width: 5,
    //                           color: Theme.of(context).colorScheme.tertiary,
    //                         ),
    //                       ),
    //                       hintText: AppLocalizations.of(context)!.email,
    //                     ),
    //                   ),
    //                   TextFormField(
    //                     controller: passwordController,
    //                     decoration: InputDecoration(
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(10),
    //                         borderSide: BorderSide(
    //                           width: 5,
    //                           color: Theme.of(context).colorScheme.tertiary,
    //                         ),
    //                       ),
    //                       hintText: AppLocalizations.of(context)!.password,
    //                     ),
    //                   ),
    //                   // Sign up with email and password
    //                   ElevatedButton(
    //                     onPressed: () {
    //                       authBloc.add(
    //                         AuthSignUpWithEmail(
    //                           email: emailController.text,
    //                           password: passwordController.text,
    //                         ),
    //                       );
    //                     },
    //                     child: Text(
    //                       AppLocalizations.of(context)!.signUpWithEmail,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         Expanded(
    //           child: Center(
    //             child: ElevatedButton(
    //               onPressed: () {
    //                 authBloc.add(AuthLogInWithGoogle());
    //               },
    //               style: ButtonStyle(
    //                 backgroundColor: MaterialStateProperty.all(
    //                   Theme.of(context).colorScheme.secondary,
    //                 ),
    //               ),
    //               child: Text(AppLocalizations.of(context)!.signUpWithGoogle),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
