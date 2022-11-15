import 'package:countdown_timer/presentation/screen/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../bloc/event/event_bloc.dart';
import '../../bloc/event/event_event.dart';
import '../../bloc/event/event_state.dart';
import '../../data/models/event.dart';

class AddEventBottomSheet extends StatefulWidget {
  const AddEventBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddEventBottomSheet> createState() => _AddEventBottomSheetState();
}

class _AddEventBottomSheetState extends State<AddEventBottomSheet> {
  final DateTime _initialDate = DateTime.now();
  DateTime _pickedDate = DateTime(2021);
  TimeOfDay _pickedTime = const TimeOfDay(hour: 00, minute: 00);

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: _initialDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      _pickedDate = pickedDate;
      _dateController.text =
          DateFormat('EEEE, MMM d, yyyy').format(pickedDate).toString();
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 00, minute: 00),
    );
    if (pickedTime != null) {
      setState(() {
        _pickedTime = pickedTime;
        _timeController.text = _pickedTime.format(context).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return makeDismissible(
      DraggableScrollableSheet(
        initialChildSize: .7,
        maxChildSize: .8,
        minChildSize: .4,
        builder: (context, draggableController) => Container(
          decoration: const BoxDecoration(
            color: Color(0xFF212121),
          ),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                color: Colors.black),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: ListView(controller: draggableController, children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  'Add Event',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    hintText: 'Add a title',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    hintText: 'Pick a date', border: OutlineInputBorder()),
                readOnly: true,
                onTap: () => _selectDate(context),
                controller: _dateController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    hintText: 'Pick a Time', border: OutlineInputBorder()),
                readOnly: true,
                onTap: () => _selectTime(context),
                controller: _timeController,
              ),
              const SizedBox(
                height: 50,
              ),
              BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  final pickedTime = DateTime(
                    _pickedDate.year,
                    _pickedDate.month,
                    _pickedDate.day,
                    _pickedTime.hour,
                    _pickedTime.minute,
                  );
                  return ElevatedButton(
                    onPressed: DateTime.now().compareTo(pickedTime) == 1 ||
                            DateTime.now().compareTo(pickedTime) == 0
                        ? null
                        : () {
                            final eventTime = DateTime(
                              _pickedDate.year,
                              _pickedDate.month,
                              _pickedDate.day,
                              _pickedTime.hour,
                              _pickedTime.minute,
                            );
                            Uuid uid = Uuid();

                            // Time time = Time(
                            //   day: _pickedDate,
                            //   hour: _pickedTime.hour,
                            //   minute: _pickedTime.minute,
                            // );
                            // if (DateTime.now().compareTo(eventTime) == -1) {
                            //   Navigator.of(context).pop();
                            // } else
                            Event event = Event(
                                title: _titleController.text,
                                time: eventTime,
                                id: uid.v1());
                            context
                                .read<EventBloc>()
                                .add(AddEvent(event: event));
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    EventDetails(event: event),
                              ),
                            );
                          },
                    style:
                        ElevatedButton.styleFrom(fixedSize: const Size(70, 50)),
                    child: const Text('START'),
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(70, 50),
                ),
                child: const Text('CANCEL'),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget makeDismissible(Widget child) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
  }
}
