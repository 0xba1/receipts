import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Logo(),
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
                            borderRadius: BorderRadius.circular(100),
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
                        onPressed: () {},
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
                  onPressed: () {},
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
