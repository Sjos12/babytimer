import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'time.dart';
import 'package:flutter/cupertino.dart';

class Schedule {
  Schedule({
    required this.name,
    required this.times,
    required this.target,
  });
  String name = '';
  List<Time> times = [];
  // Target hours in a day (sum of all lengths)
  int target = 0;
  // Total hours currently selected
  int total = 0;

  factory Schedule.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Schedule(
      name: data?['name'],
      times: data?['times'],
      target: data?['target'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "target": target,
      "total": total,
      "times": times.map((Time time) {
        return time.toMap();
      }).toList(),
    };
  }
}
