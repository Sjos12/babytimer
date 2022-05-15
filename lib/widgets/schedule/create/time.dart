import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/time.dart';

class TimeCard extends StatefulWidget {
  late int index;
  late Time time;

  final updateTime;
  TimeCard(
      {required Key key,
      required this.index,
      required this.time,
      this.updateTime})
      : super(key: key);
  @override
  _TimeCardState createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Wrap(
        spacing: 20,
        children: <Widget>[
          Text(
            'Item ' + widget.time.type,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
            ),
          ),
          Expanded(
              child: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Hours',
            ),
            onChanged: (text) {
              widget.time.length = int.parse(text);
              widget.updateTime(widget.time, widget.index);
            },
          )),
        ],
      ),
    );
  }
}
