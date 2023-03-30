import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class MyLocation extends StatefulWidget {
  @override
  _MyLocationState createState() => _MyLocationState();
}


class _MyLocationState extends State<MyLocation> {
  Position? _currentPosition;
  late GoogleMapController mapController;
  LatLng _center = LatLng(0, 0);


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _getCurrentLocation() async {
    await Geolocator.requestPermission();
    final position = await Geolocator.getCurrentPosition();
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    ).then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Location on Map Example"),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("_currentPosition"),
                  position: _center,
                  infoWindow: InfoWindow(
                      title: "Current Location",
                      snippet:
                      "lat: ${_currentPosition
                          ?.latitude}, lng: ${_currentPosition?.longitude}"),
                )
              },
            ),
            // GoogleMap(
            //   initialCameraPosition: CameraPosition(
            //     target: LatLng(37.4219999,-122.0840575),
            //     zoom: 10,
            //   ),
            // ),
            Positioned(
              bottom: 50,
              left: 20,
              child: ElevatedButton(
                onPressed: () {
                  _getCurrentLocation();
                },
                // color: Colors.blue,
                child: Text(
                  "Get Current Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}