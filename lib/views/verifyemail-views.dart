import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdev/routes.dart';
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
              final user = FirebaseAuth.instance.currentUser;
              try {
                await user?.sendEmailVerification();
              } on FirebaseAuthException catch (e) {
                if (e.code == 'too-many-requests') {
                  await showErrorDialog(
                    context,
                    'Too many requests. Please try again later.',
                  );
                } else {
                  await showErrorDialog(context, 'Error: ${e.code}');
                }
              }
            },
            child: const Text('Send Verification Email'),
          ),
          //TextButton(
          //onPressed: () async {
          //await FirebaseAuth.instance.signOut();
          //Navigator.of(
          // context,
          //).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          //},
          //child: const Text('Restart'),
          //),
        ],
      ),
    );
  }
}
