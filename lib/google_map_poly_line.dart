import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsPolyLineEx extends StatefulWidget {
  const GoogleMapsPolyLineEx({Key? key}) : super(key: key);

  @override
  State<GoogleMapsPolyLineEx> createState() => _GoogleMapsPolyLineExState();
}

class _GoogleMapsPolyLineExState extends State<GoogleMapsPolyLineEx> {

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyCZsmEUwxxcuVlDPirj_BuDLCFeDA-Z6as";

  StreamSubscription<Position>? positionStream;
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
    _kGooglePlex = CameraPosition(
      target: LatLng(32.549443, 35.871446),
      zoom: 14,
    );
    // myMarker.add(Marker(markerId: const MarkerId('1'), position: LatLng(lat,longi)));



  }

  @override
  void initState() {
    getPer();
    getLatAndLong();
    // positionStream = Geolocator.getPositionStream().listen(
    //         (Position? position) {
    //       // print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
    //   changeMarker(position!.latitude , position.longitude);
    // }
    //     );
    getPolyline();
    setState(() {});
    super.initState();
  }

  //final Completer<GoogleMapController> _controller = Completer();

  GoogleMapController? gmc;



  Set<Marker> myMarker = {

  };

  changeMarker(newlat , newlongi){
    // myMarker.remove(Marker(markerId: MarkerId ('1')));
    myMarker.clear();

    myMarker.add(Marker(markerId: const MarkerId('1') , position: LatLng(newlat , newlongi)));
    gmc?.animateCamera(CameraUpdate.newLatLng(LatLng(newlat, newlongi)));
    setState(() {

    });
  }

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
                      tiltGesturesEnabled: true,
                      compassEnabled: true,
                      scrollGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      polylines: Set<Polyline>.of(polylines.values),
                      onTap: (layLang){

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

  addPolyLine() {

    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      width: 3,

        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }
  getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        const PointLatLng(32.549443, 35.871446),
        const PointLatLng(32.551813, 35.876707),
        travelMode: TravelMode.driving,
       );
    // if (result.points.isNotEmpty) {
    //   result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(const LatLng(32.549443, 35.871446));
        polylineCoordinates.add(const LatLng(32.551813, 35.876707));

    // });
    // }
    addPolyLine();
  }

}


//
