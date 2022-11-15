import 'package:countdown_timer/data/models/event.dart';
import 'package:equatable/equatable.dart';

class EventEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddEvent extends EventEvent {
  Event event;
  AddEvent({required this.event});
}
