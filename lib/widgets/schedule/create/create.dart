import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/time.dart';
import 'package:untitled/widgets/layout.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  late TextEditingController _name;
  late List<Time> _times;

  void initState() {
    _name = TextEditingController();
    _times = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Layout(
      title: 'Create a schedule',
      body: Center(
          child: Column(
        children: <Widget>[
          TextField(),
          SingleChildScrollView(
            child: ReorderableListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              children: <Widget>[
                for (int index = 0; index < _times.length; index += 1)
                  Card(
                    key: Key('$index'),
                    child: Row(
                      children: const <Widget>[
                        Text('Item nap'),
                        TextField(),
                      ],
                    ),
                  ),
              ],
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final Time item = _times.removeAt(oldIndex);
                  _times.insert(newIndex, item);
                });
              },
            ),
          ),
          Row(
            children: [
              FloatingActionButton(
                  child: Text('Add nap'),
                  onPressed: () {
                    Time time =
                        Time(type: 'nap', length: 3000, order: 3, target: 4000);
                    setState(() {
                      _times = [..._times, time];
                    });
                  }),
              FloatingActionButton(child: Text('Add sleep'), onPressed: () {}),
              FloatingActionButton(
                  child: Text('Add wake time'), onPressed: () {}),
            ],
          )
        ],
      )),
    );
  }
}
