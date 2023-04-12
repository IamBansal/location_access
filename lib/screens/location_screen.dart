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




// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class CurrentLocationScreen extends StatefulWidget {
//   const CurrentLocationScreen({Key? key}) : super(key: key);
//
//   @override
//   _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
// }
//
// class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
//   late GoogleMapController googleMapController;
//
//   static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);
//
//   Set<Marker> markers = {};
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("User current location"),
//         centerTitle: true,
//       ),
//       body: GoogleMap(
//         initialCameraPosition: initialCameraPosition,
//         markers: markers,
//         zoomControlsEnabled: false,
//         mapType: MapType.normal,
//         onMapCreated: (GoogleMapController controller) {
//           googleMapController = controller;
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () async {
//           Position position = await _determinePosition();
//
//           googleMapController
//               .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));
//
//
//           markers.clear();
//
//           markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));
//
//           setState(() {});
//
//         },
//         label: const Text("Current Location"),
//         icon: const Icon(Icons.location_history),
//       ),
//     );
//   }
//
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled');
//     }
//
//     permission = await Geolocator.checkPermission();
//
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//
//       if (permission == LocationPermission.denied) {
//         return Future.error("Location permission denied");
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied');
//     }
//
//     Position position = await Geolocator.getCurrentPosition();
//
//     return position;
//   }
// }