import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdev/firebase_options.dart';
import 'package:flutterappdev/views/login-views.dart';
import 'package:flutterappdev/views/register-views.dart';

void main() {
  // enable flutter binding before runApp to ensure that Firebase is initialized before the app runs
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MyHomePage(),
      routes: {
        '/Login/': (context) => const LoginView(),
        '/Register/': (context) => const RegisterView(),
      },
    ),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            //final user = FirebaseAuth.instance.currentUser;
            // print(user);
            // if (user?.emailVerified ?? false) {
            //return const Text('Done');
            // } else {
            // return const VerifyEmailView();
            //  }
            return const LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

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
          const Text('Please verify your email'),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text('Send Verification Email'),
          ),
        ],
      ),
    );
  }
}
