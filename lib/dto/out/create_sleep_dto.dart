class SleepData {
  final DateTime sleepStart;
  final DateTime sleepEnd;
  final Duration duration;

  SleepData({
    required this.sleepStart,
    required this.sleepEnd,
    required this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      'sleepStart': sleepStart.toUtc().toIso8601String(),
      'sleepEnd': sleepEnd.toUtc().toIso8601String(),
      'duration': duration.inMinutes, // Store duration in minutes as an integer
    };
  }



  factory SleepData.fromJson(Map<String, dynamic> json) {
    final sleepStart = DateTime.parse(json['sleepStart']);
    final sleepEnd = DateTime.parse(json['sleepEnd']);

    // Calculate the duration based on the absolute time difference
    final duration = sleepEnd.isAfter(sleepStart)
        ? sleepEnd.difference(sleepStart)
        : sleepStart.difference(sleepEnd);

    return SleepData(
      sleepStart: sleepStart,
      sleepEnd: sleepEnd,
      duration: duration,
    );
  }

}