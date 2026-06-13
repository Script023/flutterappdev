import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterappdev/services/auth/bloc/auth_bloc.dart';
import 'package:flutterappdev/services/auth/bloc/auth_event.dart';
import 'package:flutterappdev/services/auth/bloc/auth_state.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {},
      child: Scaffold(
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
              onPressed: () {
                context.read<AuthBloc>().add(
                  const AuthEventSendEmailVerification(),
                );
              },
              child: const Text('Send Verification Email'),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                  const AuthEventLogOut(),
                );
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}
