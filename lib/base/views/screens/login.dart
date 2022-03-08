import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Form(
            key: logInFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                ),
                TextFormField(
                  controller: passwordController,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Log In With Email'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Log In With Google'),
          ),
        ],
      ),
    );
  }
}
