import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/auth.dart';
import 'package:untitled/models/schedule.dart';
import 'package:untitled/models/time.dart';

/**
 * Helper class for generating times for given schedule
 */

class ScheduleGenerator {
  Schedule schedule;
  ScheduleGenerator({required this.schedule});

  /** Generate the schedule**/

  ScheduleGenerator generate() {
    // Sort by order
    schedule.times.sort((a, b) => a.order.compareTo(b.order));

    DateTime activeDateTime = DateTime.now();
    // First start_time is current time
    for (Time time in schedule.times) {
      print(activeDateTime.toLocal());
      time.startTime = activeDateTime.toString();
      activeDateTime = activeDateTime.add(Duration(hours: time.length));
      time.endTime = activeDateTime.toString();
    }

    return this;
  }

  void save() {
    Auth auth = Auth();
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection('schedules')
        .doc(auth.getUser()!.uid.toString())
        .collection(auth.getUser()!.uid.toString())
        .doc(schedule.uid.toString())
        .update(schedule.toMap());
  }
}
