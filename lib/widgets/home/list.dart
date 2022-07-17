import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/enums/time_types.dart';
import 'package:untitled/models/auth.dart';
import 'package:untitled/models/schedule.dart';
import 'package:untitled/models/schedule_generator.dart';
import 'package:untitled/widgets/home/item.dart';

class ScheduleList extends StatelessWidget {
  List _list = [];

  @override
  Widget build(BuildContext context) {
    Auth auth = Auth();
    FirebaseFirestore db = FirebaseFirestore.instance;
    final _stream = db
        .collection("schedules")
        .doc(auth.getUser()!.uid)
        .collection(auth.getUser()!.uid)
        .withConverter(
            toFirestore: (Schedule schedule, options) => schedule.toMap(),
            fromFirestore: (snapshot, options) =>
                Schedule.fromFirestore(snapshot, options))
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
                Schedule data = document.data() as Schedule;
                return ListItem(schedule: data);
              })
              .toList()
              .cast(),
        );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({Key? key, required this.schedule}) : super(key: key);
  Schedule schedule;
  String actionButtonText = 'Save';

  @override
  Widget build(BuildContext context) {
    if (schedule.active == false) {
      actionButtonText = 'Start schedule';
    }

    void activate() {
      schedule.active = true;
    }

    Widget? getActiveIcon() {
      switch (schedule.activeTime!.type) {
        case (TimeTypes.nap):
        case (TimeTypes.sleep):
          return const Icon(CupertinoIcons.zzz);
          break;
        case (TimeTypes.wake):
          return const Icon(CupertinoIcons.sun_max);
          break;
        default:
          return const FlutterLogo();
      }
    }

    return Column(
      children: <Widget>[
        Card(
            child: ListTile(
          onLongPress: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => ItemPage(
                        schedule: schedule,
                      ))),
          leading: getActiveIcon(),
          title: Text(schedule.name),
          subtitle: Text('active ' + schedule.active.toString()),
          trailing: ElevatedButton(
            child: Text(actionButtonText),
            onPressed: () {
              schedule.active = !schedule.active;
              ScheduleManager(schedule: schedule).generate().save();
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ItemPage()),
              );*/
            },
          ),
          onTap: () {},
        )),
      ],
    );
  }
}
