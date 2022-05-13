import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/widgets/layout.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
        title: 'Baby Timer',
        actionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              print('foo');
            }),
        body: SingleChildScrollView(child: List()));
  }
}

class List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            for (int i = 0; i < 20; i++) ListItem(),
          ],
        ));
  }
}

class ListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
            child: ListTile(
          title: Text('Baby joe sleep'),
          subtitle: Text('subfoo'),
          trailing: ElevatedButton(
            child: Text('Wake up'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ItemPage()),
              );
            },
          ),
          onTap: () {},
        )),
      ],
    );
  }
}

class ItemPage extends StatelessWidget {
  const ItemPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Foo'),
        ),
        body: Center(
          child: Text('this is the detail view'),
        ));
  }
}
