import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterappdev/views/login-views.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterappdev/helpers/loading/loading_screen.dart';
import 'package:flutterappdev/services/auth/bloc/auth_bloc.dart';
import 'package:flutterappdev/services/auth/bloc/auth_event.dart';
import 'package:flutterappdev/services/auth/bloc/auth_state.dart';
import 'package:flutterappdev/services/auth/firebase_auth_provider.dart';
import 'package:flutterappdev/views/forgot_password_view.dart';
import 'package:flutterappdev/views/intro_page_view.dart';
import 'package:flutterappdev/views/notes/notes_view.dart';
import 'package:flutterappdev/views/register-views.dart';
import 'package:flutterappdev/views/verifyemail-views.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final introCounter = prefs.getInt('introCounter') ?? 0;

  runApp(
    BlocProvider(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: MyApp(introCounter: introCounter),
    ),
  );
}

class MyApp extends StatelessWidget {
  final int introCounter;
  const MyApp({super.key, required this.introCounter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(introCounter: introCounter),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int introCounter;
  const MyHomePage({super.key, required this.introCounter});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(const AuthEventIntialize());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        print('current Authstate: ${state.runtimeType}');
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          if (widget.introCounter < 5) {
            return const IntroPageView();
          } else {
            return const LoginView();
          }
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
    );
  }
}
