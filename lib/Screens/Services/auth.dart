// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider {
  final FirebaseAuth _firebaseAuth;

  AuthenticationProvider(this._firebaseAuth);

  Stream<User> get authState => _firebaseAuth.idTokenChanges();

  // Register User
  Future signUpEmailAndPassword({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //Sign in User

  Future signInWithEmailAndPassword({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //Sign Out User

  Future signOut() async {
    await _firebaseAuth.signOut();
  }
}
