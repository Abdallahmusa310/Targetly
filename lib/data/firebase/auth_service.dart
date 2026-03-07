import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user;
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user;
  }

  Future<void> resetPassword({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
