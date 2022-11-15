import 'dart:async';

import 'package:bloc/bloc.dart';

import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventState()) {
    on<AddEvent>(_addEvent);
  }
  Timer? _timer;

  void _addEvent(AddEvent event, Emitter<EventState> emit) async {
    final state = this.state;
    emit(EventState(events: List.from(state.events)..add(event.event)));
    //   _timer = Timer.periodic(
    //     const Duration(milliseconds: 1),
    //     (timer) {
    //       final currentEvent = event.event;
    //       DateTime currentTime = DateTime.now();
    //       final eventTime = currentEvent.time;
    //       final durationLeft = eventTime.difference(currentTime);
    //       //currentEvent.remainingTime!.day = durationLeft.inDays;
    //       if (durationLeft.inDays < 1) {
    //         currentEvent.remainingTime!.hour = durationLeft.inHours;
    //       } else {
    //         currentEvent.remainingTime!.hour = 24 - currentTime.hour;
    //       }
    //       if (durationLeft.inHours < 1) {
    //         currentEvent.remainingTime!.minute = durationLeft.inMinutes;
    //       } else {
    //         currentEvent.remainingTime!.minute = 60 - currentTime.minute;
    //       }
    //       if (durationLeft.inMinutes < 1) {
    //         currentEvent.remainingTime!.second = durationLeft.inSeconds;
    //       } else {
    //         currentEvent.remainingTime!.second = 60 - currentTime.second;
    //       }
    //       if (durationLeft.inSeconds < 1) {
    //         currentEvent.remainingTime!.milliseconds =
    //             durationLeft.inMilliseconds;
    //       } else {
    //         currentEvent.remainingTime!.milliseconds =
    //             1000 - currentTime.millisecond;
    //       }
    //       if (durationLeft.inMilliseconds == 0) {
    //         _timer!.cancel();
    //       }
    //     },
    //   );
  }
}
