import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/widgets/home/list.dart';
import 'package:untitled/widgets/layout.dart';
import 'package:untitled/widgets/schedule/create/create.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
        title: 'Baby Timer',
        actionButton: Builder(
          builder: (context) => FloatingActionButton(
              heroTag: 'add',
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Create()));
              }),
        ),
        body: SingleChildScrollView(child: List()));
  }
}
