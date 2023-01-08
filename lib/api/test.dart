import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  var userName;

  getPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString('pass');
    });

    print('success');
  }

  deletePref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('name');
    pref.remove('pass');
    // pref.clear();
    print('remove');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Test ${userName}',
              style: const TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () {
                  getPrefs();
                },
                child: const Text('Get pref')),
            ElevatedButton(
                onPressed: () {
                  deletePref();
                },
                child: const Text('Delete pref'))
          ],
        ),
      ),
    );
  }
}
