import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class FontEx extends StatefulWidget {
  const FontEx({Key? key}) : super(key: key);

  @override
  State<FontEx> createState() => _FontExState();
}

class _FontExState extends State<FontEx> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Sahar', style: TextStyle(fontSize: 50.0 , ),)//fontFamily: 'Oswald'

      ),
    );
  }
}
