import 'package:flutterappdev/services/auth/auth_user.dart';

// Create an abstract class for the authentication provider
// we have basically used two types of authentication providers
// which are basically the google email and password, there are so many
// authentication provider you can go to the firebase console click on
// authentication to get other instances of signing in
abstract class AuthProvider {
  // getter method used to get authuser which can also be null
  AuthUser? get currentUser;
  Future<AuthUser> login({required String email, required String password});
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<void> sendEmailVerification();
}
