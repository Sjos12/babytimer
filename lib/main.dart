import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/pages/home.dart';
import 'package:untitled/pages/login.dart';
import 'package:untitled/pages/register.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // Init fireflutter
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Init firebaseauth emulator
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // Check auth state to choose widget

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('Not logged in');
      runApp(Register());
    } else {
      print('logged in');
      runApp(MyApp());
    }
  });
}
