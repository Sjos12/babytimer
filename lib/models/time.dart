class Time {
  Time(
      {required this.type,
      required this.length,
      required this.order,
      required this.target,
      this.startTime,
      this.endTime});

  // Nap or sleep
  String type;
  // Order of times
  int order;
  // Max length of time;
  int target;
  // Actual length of time
  int length;

  String? startTime = DateTime.now().toString();
  String? endTime = DateTime.now().add(const Duration(hours: 1)).toString();

  Map<String, dynamic> toMap() {
    return {
      "order": order,
      "type": type,
      "target": target,
      "length": length,
      "start_time": startTime,
      "end_time": endTime
    };
  }
}
