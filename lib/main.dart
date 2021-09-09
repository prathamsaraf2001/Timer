import 'package:alarm_app/alarmpage.dart';

import 'package:alarm_app/stopwatch/stopwatch.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'timer/timer.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'wrightpro'),
      initialRoute: "/timer",
      routes: {
        "/alarmpage": (context) => AlarmPage(),
        "/timer": (context) => CountDownTimerPage(),
        "/stopwatch": (context) => CountUpTimerPage(),
      },
    );
  }
}
