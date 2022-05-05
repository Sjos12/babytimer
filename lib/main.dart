import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                print('foo');
              }),
          appBar: AppBar(
            title: Text('Hello world'),
          ),
          body: List(),
        ));
  }
}2

class List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListTile(
      title: Text('foo'),
      subtitle: Text('subfoo'),
      trailing: ElevatedButton(
        child: Text('foo'),
        onPressed: () {},
      ),
      onTap: () {},
    ));
  }
}
