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
  int target;
  int total = 0;
}
