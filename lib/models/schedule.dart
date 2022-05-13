import 'dart:collection';
import 'time.dart';
import 'package:flutter/cupertino.dart';

class Schedule extends ChangeNotifier {
  final List<Time> _waketimes = [];
  String _name = '';
  UnmodifiableListView<Time> get waketimes => UnmodifiableListView(_waketimes);
  String get name => _name;
}
