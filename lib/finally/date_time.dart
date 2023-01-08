import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class DateTimeEx extends StatefulWidget {
  const DateTimeEx({Key? key}) : super(key: key);

  @override
  State<DateTimeEx> createState() => _DateTimeExState();
}

class _DateTimeExState extends State<DateTimeEx> {

  DateTime? dt1 = DateTime.now();
  DateTime? dt2 = DateTime.now().add(Duration(days: 10));
  DateTime? dt3 = DateTime.now().subtract(Duration(days: 10));

  changeLocal()async{
    await Jiffy.locale('ar');
  }
  @override
  void initState() {
    changeLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print(DateTime.now());
            print(DateTime.now().day);
            print(DateTime.now().hour);
            print(DateTime.now().minute);
            print(DateTime.now().month);
            print(DateTime.now().year);
            print(DateTime.now().add(Duration(days: 10 , seconds: 10 , minutes: 30)));
            print(DateTime.now().subtract(Duration(days: 10 , seconds: 10 , minutes: 30)));

            print(dt1!.isBefore(dt2!));
            print(dt2!.isBefore(dt3!));

            print(dt1!.isAfter(dt2!));
            print(dt1!.isAtSameMomentAs(dt2!));

            print(Jiffy(dt1).E);
            print(Jiffy(dt1).EEEE);
            print(Jiffy(dt1).day);
            print(Jiffy(dt1).hour);
            print(Jiffy(dt1).j);
            print(Jiffy(dt1).yM);
            print(Jiffy(dt1).format('MMM, dd yyyy'));
            print(Jiffy(dt1).format('MMM, do yyyy'));
            print(Jiffy(dt1).fromNow());
            print(Jiffy(dt3).fromNow());







          },
          child: Text('Show'),
        ),
      ),
    );
  }
}
