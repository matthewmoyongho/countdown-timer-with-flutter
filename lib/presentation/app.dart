import 'package:countdown_timer/presentation/screen/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_export.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventBloc(),
      child: MaterialApp(
        theme: appTheme,
        home: EventsScreen(),
      ),
    );
  }
}

final appTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  dividerColor: Colors.black54,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
  ),
  inputDecorationTheme:
      InputDecorationTheme(hintStyle: TextStyle(color: Colors.grey)),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
    ),
  ),
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Colors.black),
  ),
);
