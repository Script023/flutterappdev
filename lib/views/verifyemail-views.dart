import 'package:flutter/material.dart';
import 'package:flutterappdev/routes.dart';
import 'package:flutterappdev/services/auth/auth_exceptions.dart';
import 'package:flutterappdev/services/auth/auth_service.dart';
import 'package:flutterappdev/utilities/show-error-dialog.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
        children: [
          const Text(
            'A verification email has been sent to your email address, please check your inbox.',
          ),
          const Text(
            'if you haven\'t received a verification email, press the send verification email button below.',
          ),
          TextButton(
            onPressed: () async {
              Authservice.firebase().currentUser;
              try {
                await Authservice.firebase().sendEmailVerification();
              } on TooManyRequestsAuthException {
                await showErrorDialog(
                  context,
                  'Too many requests. Please try again later.',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'An error occurred while sending the email verification. Please try again later.',
                );
              }
            },
            child: const Text('Send Verification Email'),
          ),
          TextButton(
            onPressed: () async {
              await Authservice.firebase().signOut();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
