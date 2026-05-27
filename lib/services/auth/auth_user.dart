import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

// needs to be immutable
@immutable
// create an object called auth user which will be instantiated on call
class AuthUser {
  // boolean value property/field which can be true/false
  final bool isEmailVerified;

  const AuthUser({required this.isEmailVerified});
  // factory method used to create this auth user which
  // will be used through out the code
  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified);
}
