import 'package:untitled/models/schedule.dart';
import 'package:untitled/models/time.dart';

/**
 * Helper class for generating times for given schedule
 */

class ScheduleGenerator {
  Schedule schedule;
  ScheduleGenerator({required this.schedule});

  /** Generate the schedule**/

  Schedule generate() {
    // Sort by order
    List<Time> times =
        schedule.times.sort((a, b) => a.order.compareTo(b.order));
    // First start_time is current time
    for (Time time in schedule.times) {}
    return schedule;
  }
}
