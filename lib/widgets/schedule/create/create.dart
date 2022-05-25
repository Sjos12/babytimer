import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/auth.dart';
import 'package:untitled/models/schedule.dart';
import 'package:untitled/models/time.dart';
import 'package:untitled/widgets/home/list.dart';
import 'package:untitled/widgets/layout.dart';
import 'package:untitled/widgets/schedule/create/time.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  late Schedule _schedule;
  int index = 0;
  FirebaseFirestore db = FirebaseFirestore.instance;

  void initState() {
    _schedule = Schedule(uid: '', name: '', target: 0, times: []);
    super.initState();
  }

  void store() {
    // Store schedule
    Auth auth = Auth();
    String path = 'schedules';
    print(path);
    // db.useFirestoreEmulator('localhost', 8080);
    print(_schedule.toMap().toString());

    db
        .collection(path)
        .doc(auth.getUser()!.uid)
        .collection(auth.getUser()!.uid)
        .add(_schedule.toMap())
        .then((DocumentReference doc) {
      Navigator.pop(context);
    });
    // Store times
  }

  @override
  Widget build(BuildContext context) {
    updateTime(Time time, int index) {
      setState(() {
        print('Updated time ${_schedule.times}');
        _schedule.times[index] = time;

        int total = 0;
        _schedule.times.forEach((Time time) {
          total += time.length;
        });
        _schedule.total = total;
      });
    }

    return Layout(
        title: 'Create a schedule',
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: TextField(
                  onChanged: (text) {
                    _schedule.name = text;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Give schedule a name',
                  ),
                ),
              ),
              Text('Planned ${_schedule.total}/24 Hours'),
              ReorderableListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                children: <Widget>[
                  for (int index = 0;
                      index < _schedule.times.length;
                      index += 1)
                    TimeCard(
                      key: Key('$index'),
                      index: index,
                      time: _schedule.times[index],
                      updateTime: updateTime,
                    )
                ],
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final Time item = _schedule.times.removeAt(oldIndex);
                    item.order = newIndex;
                    _schedule.times.insert(newIndex, item);
                  });
                },
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  FloatingActionButton(
                      heroTag: 'nap',
                      child: Text('Add nap'),
                      onPressed: () {
                        Time time = Time(
                            type: 'nap',
                            length: 3000,
                            order: index,
                            target: 4000);
                        index++;
                        setState(() {
                          _schedule.times = [..._schedule.times, time];
                        });
                      }),
                  FloatingActionButton(
                      heroTag: 'sleep',
                      child: Text('Add sleep'),
                      onPressed: () {
                        Time time = Time(
                            type: 'sleep',
                            length: 3000,
                            order: index,
                            target: 4000);
                        index++;
                        setState(() {
                          _schedule.times = [..._schedule.times, time];
                        });
                      }),
                  FloatingActionButton(
                      heroTag: 'waketime',
                      child: Text('Add waketime'),
                      onPressed: () {
                        Time time = Time(
                            type: 'wake',
                            length: 3000,
                            order: index,
                            target: 4000);
                        index++;
                        setState(() {
                          _schedule.times = [..._schedule.times, time];
                        });
                      }),
                ],
              ),
              FloatingActionButton(
                  heroTag: 'save',
                  child: Text('Save'),
                  onPressed: () => store())
            ],
          )),
        ));
  }
}
