import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/enums/time_types.dart';

import 'time.dart';
import 'package:flutter/cupertino.dart';

class Schedule {
  Schedule({
    required this.uid,
    required this.name,
    required this.times,
    //required this.target,
  });
  String uid = '';
  String name = '';
  List<Time> times = [];

  // Total hours currently selected
  int total = 0;
  bool active = false;

  Time? get activeTime {
    DateTime now = DateTime.now();
    for (Time time in times) {
      DateTime startDate = DateTime.parse(time.startTime);
      DateTime endDate = DateTime.parse(time.endTime);
      if (now.isAfter(startDate) && now.isBefore(endDate)) {
        return time;
      }
    }
    return null;
  }

  // Target hours in a day (sum of all lengths)
  int get targetHours {
    int target = 0;
    for (Time time in times) {
      target += time.length;
    }
    return target;
  }

  factory Schedule.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    // Convert times to model.
    List<Time> times = (data?['times'] as List<dynamic>)
        .map((dynamic time) => Time(
              length: time['length'],
              order: time['order'],
              target: time['target'],
              type: TimeTypes.values
                  .firstWhere((e) => e.toString() == time['type']),
              startTime: time['start_time'],
              endTime: time['end_time'],
            ))
        .toList();
    return Schedule(
      uid: snapshot.id,
      name: data?['name'],
      times: times,
      // target: data?['target'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "active": active,
      //  "target": target,
      "total": total,
      "times": times.map((Time time) {
        return time.toMap();
      }).toList(),
    };
  }
}
