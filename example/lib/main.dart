import 'dart:developer';

import 'package:date_time_piker_plus/date_time_piker/date_piker.dart';
import 'package:date_time_piker_plus/date_time_piker/dialog_datetime_piker.dart';
import 'package:date_time_piker_plus/date_time_piker/dropdown_datetime_piker.dart';
import 'package:date_time_piker_plus/date_time_piker/time_piker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Date Time Piker Plus',
      home: MyHomePage(title: 'Date Time Piker Plus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DateTimePickerPlusDialog(),
            DateTimePickerPlusDropdown(onPress: (p0) {
              
            },),
            TimeSelectorPlus(
              onChange: (TimeOfDay timeOfDay) {
                log(timeOfDay.toString());
              },
            ),
            DatePickerPlus(
              onChange: (DateTime date) {
                log(date.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
