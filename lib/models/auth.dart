import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Auth {
  late User? user;
  Auth() {
    FirebaseAuth.instance.authStateChanges().listen((User? firebaseuser) {
      if (firebaseuser != null) {
        user = firebaseuser;
      }
    });
  }
  bool isLoggedIn() {
    if (user != null) {
      return true;
    }
    return false;
  }

  User? getUser() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser;
    }
    return null;
  }

  void signUp(String email, String password) async {
    UserCredential response =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    // Save user.
    user = response.user;
    var db = FirebaseFirestore.instance;
    // Store in firestore
    db.collection('users').doc(user?.uid).set({});
  }

  void signIn(String email, String password) async {
    UserCredential response =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    user = response.user;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
