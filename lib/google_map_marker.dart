import 'dart:async';


// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsMarkerEx extends StatefulWidget {
  const GoogleMapsMarkerEx({Key? key}) : super(key: key);

  @override
  State<GoogleMapsMarkerEx> createState() => _GoogleMapsMarkerExState();
}

class _GoogleMapsMarkerExState extends State<GoogleMapsMarkerEx> {
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
    c1 = await Geolocator.getCurrentPosition().then((value) => value);
    lat = c1!.latitude;
    longi = c1!.longitude;
    _kGooglePlex = const CameraPosition(
      target: LatLng(32.549443, 35.871446),
      zoom: 14,
    );
    setState(() {});
  }

  @override
  void initState() {
    getPer();
    getLatAndLong();
    setMarkerCustomImage();

    super.initState();
  }

  //final Completer<GoogleMapController> _controller = Completer();

  GoogleMapController? gmc;

  setMarkerCustomImage()async{
    myMarker.add(Marker(
      onTap: (){
        print('tab3 marker');
      },
      draggable: true,
      onDragEnd: (LatLng t){
        print('drag end on $t');
      },
      icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'images/logo.png', ),
      markerId: const MarkerId('3'),
      position: const LatLng(32.554298380769424, 35.87058596313),
      infoWindow: InfoWindow(
          title: '3',
          onTap: () {
            print('tab3 info marker');
          }),
    ));

  }


  Set<Marker> myMarker = {
    Marker(
      visible: true,
      onTap: (){
        print('tab1 marker');
      },
      draggable: true,
      onDragEnd: (LatLng t){
        print('drag end on $t');
      },
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      markerId: const MarkerId('1'),
      position: const LatLng(32.549443, 35.871446),
      infoWindow: InfoWindow(
          title: '1',
          onTap: () {
            print('tab1 info marker');
          }),
    ),
    Marker(
        onTap: (){
          print('tab2 marker');
        },
        markerId: const MarkerId('2'),
        position: const LatLng(32.551813, 35.876707),
        infoWindow: InfoWindow(
            title: '2',
            onTap: () {
            print('tab2 info marker');
        }))
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            _kGooglePlex == null
                ? const CircularProgressIndicator()
                : SizedBox(
                    height: 500,
                    width: 400,
                    child: GoogleMap(
                      onTap: (layLang){
                        myMarker.remove(Marker(markerId: MarkerId ('1')));
                        myMarker.add(Marker(markerId: MarkerId('1') , position: layLang));
                        setState(() {
                          print(layLang.longitude);
                          print(layLang.latitude);

                        });
                      },
                      markers: myMarker,
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
                  LatLng latlng = const LatLng(32.549443, 35.871446);

                  var lats = await gmc!
                      .getLatLng(const ScreenCoordinate(x: 200, y: 200));
                  // var lats= await gmc!.getZoomLevel();

                  print(lats);
                },
                child: const Text('HOME'))
          ],
        ));
  }
}
