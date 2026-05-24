import 'package:flutterappdev/services/auth/auth_provider.dart';
import 'package:flutterappdev/services/auth/auth_user.dart';

// Auth service contains the Authprovider
class Authservice implements AuthProvider {
  final AuthProvider provider;

  const Authservice(this.provider);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) => provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> login({required String email, required String password}) =>
      provider.login(email: email, password: password);

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
}
