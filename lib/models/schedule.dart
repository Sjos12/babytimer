import 'dart:collection';
import 'time.dart';
import 'package:flutter/cupertino.dart';

class Schedule {
  Schedule({
    required this.name,
    required this.times,
    required this.target,
  });
  String name;
  List<Time> times;
  // Target hours in a day (sum of all lengths)
  int target;
  // Total hours currently selected
  int total = 0;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "target": target,
      "total": total,
    };
  }
}
