import '../models/time.dart';

class Event {
  String? id;
  String title;
  DateTime time;
  RemainingTime? remainingTime;
  Event({
    required this.title,
    required this.time,
    this.remainingTime,
    this.id,
  }) {
    remainingTime ??=
        RemainingTime(day: 0, hour: 0, minute: 0, second: 0, milliseconds: 0);
  }
}
