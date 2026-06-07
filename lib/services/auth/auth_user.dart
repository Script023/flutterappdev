import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

// needs to be immutable
@immutable
// create an object called auth user which will be instantiated on call
class AuthUser {
  // boolean value property/field which can be true/false
  final bool isEmailVerified;
  final String email;
  final String id;

  const AuthUser({
    required this.email, 
    required this.isEmailVerified, 
    required this.id});
  // factory method used to create this auth user which
  // will be used through out the code
  factory AuthUser.fromFirebase(User user) => AuthUser(
    // read from the firebase user
    email: user.email!,
    id: user.uid,
    isEmailVerified: user.emailVerified,
  );
}
