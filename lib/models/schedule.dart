import 'dart:collection';
import 'time.dart';
import 'package:flutter/cupertino.dart';

class Schedule {
  Schedule({
    required this.times,
    required this.target,
  });
  List<Time> times;
  int target;
}
