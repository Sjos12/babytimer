import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/auth.dart';
import 'package:untitled/models/schedule.dart';
import 'package:untitled/widgets/home/item.dart';

class ScheduleList extends StatelessWidget {
  List _list = [];

  Future<void> getList() async {}
  @override
  Widget build(BuildContext context) {
    Auth auth = Auth();
    FirebaseFirestore db = FirebaseFirestore.instance;
    final _stream = db
        .collection("schedules")
        .withConverter(
            toFirestore: (Schedule schedule, options) => schedule.toMap(),
            fromFirestore: Schedule.fromFirestore)
        .doc(auth.getUser()!.uid)
        .collection(auth.getUser()!.uid)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Column(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListItem(schedule: data);
              })
              .toList()
              .cast(),
        );
      },
    );

    @override
    Widget build(BuildContext context) {
      getList();
      return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < _list.length; i++)
                ListItem(schedule: _list[i]),
            ],
          ));
    }
  }
}

class ListItem extends StatelessWidget {
  ListItem({Key? key, required this.schedule}) : super(key: key);
  Object schedule;
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
