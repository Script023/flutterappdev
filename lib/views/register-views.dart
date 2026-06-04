import 'package:flutter/material.dart';
import 'package:flutterappdev/routes.dart';
import 'package:flutterappdev/services/auth/auth_exceptions.dart';
import 'package:flutterappdev/services/auth/auth_service.dart';
import 'package:flutterappdev/utilities/dailogs/error_dailog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter your email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter your password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await Authservice.firebase().createUser(
                  email: email,
                  password: password,
                );
                //this usage of pushnamed route is simply because we dont replace the entire
                //screen with the login screen, we just want
                //to push the verifyemail screen
                Authservice.firebase().currentUser;
                await Authservice.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(context, 'weak password');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, 'email-already-in-use');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'invalid-email');
              } on GenericAuthException {
                await showErrorDialog(context, 'Authentication error');
              }
            },

            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Already have an account? Login here!'),
          ),
        ],
      ),
    );
  }
}
