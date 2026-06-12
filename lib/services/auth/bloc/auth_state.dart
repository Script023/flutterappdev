import 'package:flutter/material.dart';
import 'package:flutterappdev/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

// lets craete a state for the authentication to describe its loading
class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedIn extends AuthState {
  // when you log in to the application whst does the application need from us
  // is the current user
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}


class AuthStateNeedVerification extends AuthState {
  const AuthStateNeedVerification();
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  const AuthStateLoggedOut(this.exception);
}

class AuthStateLoggedOutFailure extends AuthState {
  const AuthStateLoggedOutFailure();
}
