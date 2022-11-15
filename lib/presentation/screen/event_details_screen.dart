import 'dart:async';

import 'package:countdown_timer/data/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc_export.dart';
import '../../bloc/event/event_state.dart';

class EventDetails extends StatefulWidget {
  EventDetails({Key? key, required this.event}) : super(key: key);
  Event? event;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer(widget.event!);
  }

  void startTimer(Event event) {
    // final event = widget.event;
    // _timer = Timer.periodic(
    //   const Duration(milliseconds: 1),
    //   (timer) {
    //     DateTime currentTime = DateTime.now();
    //     final eventTime = event!.time;
    //     final durationLeft = eventTime.difference(currentTime);
    //     event.remainingTime!.day = durationLeft.inDays;
    //     setState(() {
    //       if (durationLeft.inDays < 1) {
    //         event.remainingTime!.hour = durationLeft.inHours;
    //       } else {
    //         event.remainingTime!.hour = 24 - currentTime.hour;
    //       }
    //       if (durationLeft.inHours < 1) {
    //         event.remainingTime!.minute = durationLeft.inMinutes;
    //       } else {
    //         event.remainingTime!.minute = 60 - currentTime.minute;
    //       }
    //       if (durationLeft.inMinutes < 1) {
    //         event.remainingTime!.second = durationLeft.inSeconds;
    //       } else {
    //         event.remainingTime!.second = 60 - currentTime.second;
    //       }
    //       if (durationLeft.inSeconds < 1) {
    //         event.remainingTime!.milliseconds = durationLeft.inMilliseconds;
    //       } else {
    //         event.remainingTime!.milliseconds = 1000 - currentTime.millisecond;
    //       }
    //       if (durationLeft.inMilliseconds < 1) {
    //         _timer!.cancel();
    //       }
    //     });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
      ),
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          Event? event =
              state.events.firstWhere((event) => event.id == widget.event!.id);

          _timer = Timer.periodic(
            const Duration(milliseconds: 1),
            (timer) {
              DateTime currentTime = DateTime.now();
              DateTime? eventTime = event.time;
              Duration? durationLeft = eventTime.difference(currentTime);
              event.remainingTime!.day = durationLeft.inDays;
              setState(() {
                if (durationLeft.inDays < 1) {
                  event.remainingTime!.hour = durationLeft.inHours;
                } else {
                  event.remainingTime!.hour = 24 - currentTime.hour;
                }
                if (durationLeft.inHours < 1) {
                  event.remainingTime!.minute = durationLeft.inMinutes;
                } else {
                  event.remainingTime!.minute = 60 - currentTime.minute;
                }
                if (durationLeft.inMinutes < 1) {
                  event.remainingTime!.second = durationLeft.inSeconds;
                } else {
                  event.remainingTime!.second = 60 - currentTime.second;
                }
                if (durationLeft.inSeconds < 1) {
                  event.remainingTime!.milliseconds =
                      durationLeft.inMilliseconds;
                } else {
                  event.remainingTime!.milliseconds =
                      1000 - currentTime.millisecond;
                }
                if (durationLeft.inMilliseconds < 1) {
                  _timer!.cancel();
                  state.events.remove(event);
                  Navigator.of(context).pop();
                  //event = null;
                }
              });
            },
          );
          return Center(
            child: Container(
              margin: const EdgeInsets.all(15),
              height: deviceSize.height * .3,
              width: double.infinity,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: const Color(0xFF212121),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        child: Text(
                          state.events.contains(event)
                              ? 'Counting down to ${widget.event!.title}'
                              : 'Time out',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),

                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white60)),
                                child: Text(
                                  '${widget.event!.remainingTime!.day}',
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white60)),
                                child: Text(
                                  '${widget.event!.remainingTime!.hour}',
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white60)),
                                child: Text(
                                  '${widget.event!.remainingTime!.minute}',
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white60)),
                                child: Text(
                                  '${widget.event!.remainingTime!.second}',
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white60)),
                                child: FittedBox(
                                  child: Text(
                                    '${widget.event!.remainingTime!.milliseconds}',
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 10,
                                width: 35,
                                alignment: Alignment.topCenter,
                                child: const FittedBox(
                                  child: Text(
                                    'DAYS',
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 35,
                                alignment: Alignment.topCenter,
                                child: const FittedBox(
                                  child: Text(
                                    'HOURS',
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 35,
                                alignment: Alignment.topCenter,
                                child: const FittedBox(
                                  child: Text(
                                    'MINUTES',
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 35,
                                alignment: Alignment.topCenter,
                                child: const FittedBox(
                                  child: Text(
                                    'SECONDS',
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 35,
                                alignment: Alignment.topCenter,
                                child: const FittedBox(
                                  child: Text(
                                    'MILLISECONDS',
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Text(
                      //   state.events.contains(event)
                      //       ? '${widget.event!.remainingTime!.day} : ${widget.event!.remainingTime!.hour} : ${widget.event!.remainingTime!.minute} : ${widget.event!.remainingTime!.second} : ${widget.event!.remainingTime!.milliseconds} '
                      //       : '0:0:0:0:0',
                      //   style: const TextStyle(fontSize: 25),
                      // ),
                      const Text(
                        'TO',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        widget.event!.title,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
