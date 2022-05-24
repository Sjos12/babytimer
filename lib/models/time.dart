class Time {
  Time({
    required this.type,
    required this.length,
    required this.order,
    required this.target,
  });

  // Nap or sleep
  String type;
  // Order of times
  int order;
  // Max length of time;
  int target;
  // Actual length of time
  int length;

  Map<String, dynamic> toMap() {
    return {
      "order": order,
      "type": type,
      "target": target,
      "length": length,
    };
  }
}
