import 'package:flutter/material.dart';
import 'package:task/api/shared_pref.dart';
import 'package:task/api/test.dart';
import 'package:task/task/main_page.dart';
import 'package:task/task/page_task.dart';

import 'api/api.dart';
import 'api/future_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  APIEX(),
      routes: {
        'first': (context) =>MainPage(),
        'second': (context) =>const SecondPage(),
        'test' : (context) =>const Test(),
      },

    );
  }
}