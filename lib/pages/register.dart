import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/home.dart';
import 'package:untitled/pages/login.dart';
import 'package:untitled/widgets/layout.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  _submit() async {
    try {
      this.user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print('went wrong');
      print(e);
    }
  }

  late UserCredential user;
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _password = TextEditingController();
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        title: 'Register',
        body: Center(
            child: Column(children: <Widget>[
          TextField(controller: _email),
          TextField(obscureText: true, controller: _password),
          FloatingActionButton(
              child: const Text('Submit'), onPressed: () => _submit()),
          FloatingActionButton(
              child: Text('check'),
              onPressed: () {
                print(this.user.user?.email);
              }),
          Builder(
              builder: (context) => FloatingActionButton(
                  child: Text('login instead'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  })),
        ])));
  }
}
