import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  register(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  signIn(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  bool isSignedIn() {
    if (_firebaseAuth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }
}
