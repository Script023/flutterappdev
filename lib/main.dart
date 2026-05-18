import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdev/firebase_options.dart';
import 'package:flutterappdev/views/login-views.dart';
import 'package:flutterappdev/views/register-views.dart';
import 'package:flutterappdev/views/verifyemail-views.dart';

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
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                print('Email is verified');
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
            // print(user);
            // if (user?.emailVerified ?? false) {
            //return const Text('Done');
            // } else {
            // return const VerifyEmailView();
            //  }
            return const Text('Done');
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
