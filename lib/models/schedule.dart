import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'time.dart';
import 'package:flutter/cupertino.dart';

class Schedule {
  Schedule({
    required this.uid,
    required this.name,
    required this.times,
    required this.target,
  });
  String uid = '';
  String name = '';
  List<Time> times = [];
  // Target hours in a day (sum of all lengths)
  int target = 0;
  // Total hours currently selected
  int total = 0;
  bool active = false;
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
              type: time['type'],
              startTime: time['start_time'],
              endTime: time['end_time'],
            ))
        .toList();
    return Schedule(
      uid: snapshot.id,
      name: data?['name'],
      times: times,
      target: data?['target'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "active": active,
      "target": target,
      "total": total,
      "times": times.map((Time time) {
        return time.toMap();
      }).toList(),
    };
  }
}
