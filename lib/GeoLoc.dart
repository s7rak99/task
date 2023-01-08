import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class GeoLoc extends StatefulWidget {
  const GeoLoc({Key? key}) : super(key: key);

  @override
  State<GeoLoc> createState() => _GeoLocState();
}

class _GeoLocState extends State<GeoLoc> {
  var c1;

  Future getPosition() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'Warning',
        desc: 'Location Not Enabled.............',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }

    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
      if (per == LocationPermission.whileInUse) {
        getLatAndLong();
      }
    }
    print('========================');
    print(per);
    print('========================');
  }

  Future<Position?> getLatAndLong() async {
    return await Geolocator.getCurrentPosition().then((value) => value);
  }

  //services location => disable ? false : true

  @override
  void initState() {
    getPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  //  c1 = await getLatAndLong() ;
                  // print( 'latitude ${c1!.latitude}');
                  // print('longitude ${c1!.longitude}');
                  //  List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
                  //  print(placemarks[0].administrativeArea);//administive //loc //con

                  var distance =  Geolocator.distanceBetween(32.549443, 35.871446 ,32.551813 , 35.876707);
                  print(distance/1000);


                },
                child: const Text('get lat-long'))
          ],
        ));
  }
}

//
// Future getData() async{
//   print('Start Function');
//   Future.delayed(Duration(seconds: 3),(){
//     print('sahar');
//   });
//   print('End Function');
// }
//



//32.549443

//35.871446


//32.551813
//35.876707
