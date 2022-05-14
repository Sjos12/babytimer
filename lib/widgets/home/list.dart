import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/widgets/home/item.dart';

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
          title: const Text('Baby joe sleep'),
          subtitle: const Text('subfoo'),
          trailing: ElevatedButton(
            child: const Text('Wake up'),
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
