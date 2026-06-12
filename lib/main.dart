import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterappdev/routes.dart';
import 'package:flutterappdev/services/auth/bloc/auth_bloc.dart';
import 'package:flutterappdev/services/auth/bloc/auth_event.dart';
import 'package:flutterappdev/services/auth/bloc/auth_state.dart';
import 'package:flutterappdev/services/auth/firebase_auth_provider.dart';
import 'package:flutterappdev/views/login-views.dart';
import 'package:flutterappdev/views/notes/create_update_note_view.dart';
import 'package:flutterappdev/views/notes/notes_view.dart';
import 'package:flutterappdev/views/register-views.dart';
import 'package:flutterappdev/views/verifyemail-views.dart';

void main() {
  // enable flutter binding before runApp to ensure that Firebase is initialized before the app runs
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const MyHomePage(),
      ),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventIntialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );

    /**return FutureBuilder(
      future: Authservice.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = Authservice.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
  **/
  }
}
