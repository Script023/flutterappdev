import 'package:flutterappdev/services/auth/auth_provider.dart';
import 'package:flutterappdev/services/auth/auth_user.dart';
import 'package:flutterappdev/services/auth/firebase_auth_provider.dart';

// Auth service contains the Authprovider
class Authservice implements AuthProvider {
  final AuthProvider provider;

  const Authservice(this.provider);
  // factory constructor which will create an instance of firebase auth provider
  factory Authservice.firebase() => Authservice(FirebaseAuthProvider());

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
  Future<void> signOut() => provider.signOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<void> sendPasswordReset({required String toEmail}) =>
      provider.sendPasswordReset(toEmail: toEmail);
}
