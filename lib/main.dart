import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:win32/win32.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Size change issue',
      home: MyHomePage(title: 'Size change issue'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final window = FindWindowEx(
              0,
              0,
              TEXT('FLUTTER_RUNNER_WIN32_WINDOW'),
              nullptr,
            );
            // Working: This code is working for Flutter 1.26.0-12.0.pre
            // Not working: It crashes the app for 1.26.0-17.8.pre
            if (window == 0) {
              throw Exception('Cannot find flutter window');
            } else {
              MoveWindow(window, 0, 0, 500, 500, TRUE);
            }
          },
          child: Text(
            'Change size',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
