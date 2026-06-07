import 'package:flutter_test/flutter_test.dart';
import 'package:flutterappdev/services/auth/auth_exceptions.dart';
import 'package:flutterappdev/services/auth/auth_provider.dart';
import 'package:flutterappdev/services/auth/auth_user.dart';

void main() {
  // what are mocks are why we need them
  // creating a new function or class which can be injected in place of the real one
  // to test the code in isolation without relying on external
  //dependecies like firebase or network calls
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });
    test('Cannot log out if not initialized', () {
      expect(
        provider.signOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });
    test('Should be able to initialize', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test('User should be null after initialization', () {
      expect(provider.currentUser, isNull);
    });
    test(
      'Should be able to initialize in less than 2 seconds',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );
    test('Create user should delegate to login function', () async {
      final badEmailUser = provider.createUser(
        email: 'foo@bar.com',
        password: 'anypassword',
      );
      expect(
        badEmailUser,
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );

      final badPasswordUser = provider.createUser(
        email: 'someone@bar.com',
        password: 'foobar',
      );
      expect(
        badPasswordUser,
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );
      final user = await provider.createUser(email: 'foo', password: 'bar');
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });
    test('Logged in user should be able to get verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });
    test('Should be able to log out and log in again', () async {
      await provider.signOut();
      await provider.login(email: 'user', password: 'password');
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

// this is a custom exception class which we will throw when the provider is not initialized
class NotInitializedException implements Exception {}
// you might be wondering what are we actually doing here
// first we craete a mock auth provider which should behave like the real
// auth provider

class MockAuthProvider implements AuthProvider {
  // this is a private variable intialize which is set to false by default and a getter
  // method iscreated to check if the provider is initialized or not
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    // we are simulating a network call or firebase call by adding a delay of 1 second
    await Future.delayed(const Duration(seconds: 1));
    // we are returning a new auth user with email verified as false
    return login(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    // we need to check if the provider is initialized or not before we can login
    if (!isInitialized) throw NotInitializedException();
    // create a fake logic to check if the email and password are correct
    if (email == 'foo@bar.com') throw UserNotFoundAuthException();
    if (password == 'foobar') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false, email: 'foo@bar.com', id: 'my_id');
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true, email: 'foo@bar.com', id: 'my_id');
    _user = newUser;
  }

  @override
  Future<void> signOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }
}
