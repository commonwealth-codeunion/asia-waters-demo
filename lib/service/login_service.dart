import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> register(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  bool isSignedIn() {
    if (_firebaseAuth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }
}
