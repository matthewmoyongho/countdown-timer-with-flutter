import 'package:countdown_timer/data/models/event.dart';

abstract class BaseEventRepository {
  Stream<Event> getAllEvent(Event event);
}
