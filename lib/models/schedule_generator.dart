import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/auth.dart';
import 'package:untitled/models/schedule.dart';
import 'package:untitled/models/time.dart';

/**
 * Helper class for generating times for given schedule
 */

class ScheduleManager {
  Schedule schedule;
  ScheduleManager({required this.schedule});

  /** Generate the schedule**/

  ScheduleManager generate() {
    // Sort by order
    schedule.times.sort((a, b) => a.order.compareTo(b.order));

    DateTime activeDateTime = DateTime.now();

    // It doesn't make sense to calculate all the times because it might change depending on user input.
    // Only calculate the first time;

    Time time = schedule.times.first;
    time.startTime = activeDateTime.toString();
    activeDateTime = activeDateTime.add(Duration(hours: time.length));
    time.endTime = activeDateTime.toString();

    return this;
  }

  void save() {
    schedule.times.sort((a, b) => a.order.compareTo(b.order));
    Auth auth = Auth();
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection('schedules')
        .doc(auth.getUser()!.uid.toString())
        .collection(auth.getUser()!.uid.toString())
        .doc(schedule.uid.toString())
        .update(schedule.toMap());
  }

  void wokeUp() {}
  void wentToSleep() {
    Time? activeTime = schedule.activeTime;
    // If a time is active and baby is awake allow wentToSleep function to be called.
    if (activeTime != null && activeTime.type == 'wake') {
      activeTime.endTime = DateTime.now().toString();

      // Get the next time.
      Time nextTime = schedule.times
          .where((time) => time.order == activeTime.order + 1)
          .toList()
          .first;

      nextTime.startTime = activeTime.endTime;

      // Save changes;
      save();
    }
  }

  void generateNextTime() {
    Time? activeTime = schedule.activeTime;
    if (activeTime == null) return;
    // Get the next time.
    Time nextTime = schedule.times
        .where((time) => time.order == activeTime.order + 1)
        .toList()
        .first;

    nextTime.startTime = activeTime.endTime;
    nextTime.endTime = DateTime.parse(nextTime.startTime as String)
        .add(Duration(hours: nextTime.length))
        .toString();
  }
}
