import 'package:countdown_timer/presentation/screen/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/bloc_export.dart';
import '../../bloc/event/event_state.dart';
import '../widget/add_event_bottom_sheet.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  // @override
  // void initState() {
  //   super.initState();
  // }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => AddEventBottomSheet(),
                );
              },
              icon: const Icon(Icons.add)),
        ],
        elevation: 0,
      ),
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          // state.events.removeWhere(
          //   (event) => event.time == DateTime.now(),
          //
          //   // event.time.millisecond < 0 &&
          //   // event.time.second < 1 &&
          //   // event.time.minute < 1 &&
          //   // event.time.hour < 1 &&
          //   // event.time.day < 1
          // );
          return ListView.builder(
            itemCount: state.events.length,
            itemBuilder: (context, index) {
              final event = state.events[index];
              // final time = event.time;
              // DateTime currentTime = DateTime.now();
              // Duration remainingTime = time.difference(currentTime);
              // String day = remainingTime.inDays.toString();
              // String hour = remainingTime.inHours.toString();
              // String minutes = (60 - currentTime.minute).toString();
              // String seconds = (60 - currentTime.second).toString();

              return ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EventDetails(
                          event: event,
                        ))),
                title: Text(
                    DateFormat("EEE, d MMM, yyyy - HH:mm").format(event.time)
                    // "yyyy-MM-dd HH:mm:ss"
                    // DateFormat("yyyy-MM-dd HH:mm:ss").format(
                    //   DateTime.now(),
                    // ),
                    ),
                subtitle: Text(event.title),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            isScrollControlled: true,
            context: context,
            builder: (context) => AddEventBottomSheet(),
          );
        },
        //isExtended: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: const Icon(Icons.add),
      ),
    );
  }
}
