import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterappdev/services/auth/auth_provider.dart';
import 'package:flutterappdev/services/auth/bloc/auth_event.dart';
import 'package:flutterappdev/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // constructor of authprovider
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    //initialze ..........
    on<AuthEventIntialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(null));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });
    // log in ..........
    on<AuthEventLogin>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.login(email: email, password: password);
        emit(AuthStateLoggedIn(user));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(e));
      }
    });
    // logOut
    on<AuthEventLogOut>((event, emit) async {
      try {
        emit(const AuthStateLoading());
        await provider.signOut();
        emit(const AuthStateLoggedOut(null));
      } on Exception catch (_) {
        emit(AuthStateLoggedOutFailure());
      }
    });
  }
}
