import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:receipts/logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    final logInFormKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Logo(),
            Form(
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
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(AppLocalizations.of(context)!.logInWithEmail),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(AppLocalizations.of(context)!.logInWithGoogle),
            ),
          ],
        ),
      ),
    );
  }
}
