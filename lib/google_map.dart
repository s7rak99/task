import 'dart:async';

// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsEx extends StatefulWidget {
  const GoogleMapsEx({Key? key}) : super(key: key);

  @override
  State<GoogleMapsEx> createState() => _GoogleMapsExState();
}

class _GoogleMapsExState extends State<GoogleMapsEx> {


  Position? c1;

  var lat;
  var longi;
  CameraPosition? _kGooglePlex;
  Future getPer() async {
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

    }
    print('========================');
    print(per);
    print('========================');
    return per;
  }

  Future<void> getLatAndLong() async {
    c1= await Geolocator.getCurrentPosition().then((value) => value);
    lat = c1!.latitude;
    longi = c1!.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, longi),
      zoom: 14.4746,
    );
    setState(() {

    });
  }


  @override
  void initState() {
    getPer();
    getLatAndLong();
    super.initState();
  }

  //final Completer<GoogleMapController> _controller = Completer();

  GoogleMapController? gmc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            _kGooglePlex == null ? CircularProgressIndicator():
            SizedBox(
              height: 500,
              width: 400,
              child:  GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex!,
                onMapCreated: (GoogleMapController controller) {
                  gmc = controller;
                  //_controller.complete(controller);
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  LatLng latlng = LatLng(32.549443, 35.871446);
                  // gmc!.animateCamera(CameraUpdate.newLatLng(latlng));
                  // gmc!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  //     target: latlng,
                  //     zoom: 10,
                  //   tilt: 45,
                  //   bearing: 45
                  // )));
                  // gmc!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  //     target: latlng,
                  //     zoom: 10,
                  //     tilt: 45,
                  //     bearing: 45
                  // )));

                  // var lats= await gmc!.getLatLng(ScreenCoordinate(x: 200, y: 200));
                  var lats= await gmc!.getZoomLevel();

                  print(lats);
                },
                child: const Text('HOME'))
          ],
        ));
  }
}



//32.549443

//35.871446


//32.551813
//35.876707
//AIzaSyCZsmEUwxxcuVlDPirj_BuDLCFeDA-Z6as