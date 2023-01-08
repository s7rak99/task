import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends StatefulWidget {
  const SharedPref({Key? key}) : super(key: key);

  @override
  State<SharedPref> createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> {

  savedPrefs()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('name', 'sahar');
    pref.setString('pass', '123');



    print('success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(onPressed: ()async{
           await savedPrefs();
          }, child: Text('Save prefs' )),
          ElevatedButton(onPressed: (){
            Navigator.of(context).pushNamed('test');
          }, child: Text('Go To Page Text' )),
        ],
      ),
    );
  }
}
