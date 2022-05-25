import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/schedule.dart';
import 'package:untitled/models/time.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ItemPage extends StatelessWidget {
  ItemPage({Key? key, required this.schedule}) : super(key: key);
  Schedule schedule;
  @override
  Widget build(BuildContext context) {
    List<Widget> timeline = [];

    for (Time time in schedule.times) {
      print(time.startTime);
      DateTime dateTime = DateTime.parse(time.startTime as String);
      String displayTime = '${dateTime.hour} : ${dateTime.minute}';
      timeline.add(TimelineTile(
        indicatorStyle: IndicatorStyle(
          color: Colors.blue,
          width: 20,
          height: 20,
          drawGap: false,
        ),
        alignment: TimelineAlign.manual,
        lineXY: 0.2,
        endChild: Card(
          child: ListTile(
            title: Text(time.type),
            subtitle: Text('Duration: ${time.length} Hrs'),
          ),
        ),
        startChild: Text(
          displayTime,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(schedule.name),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Wrap(direction: Axis.horizontal, spacing: 20, children: timeline),
        )));
  }
}
