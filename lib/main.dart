
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pomodoro/pomodoro.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pomodoro(),
    );
  }
}

