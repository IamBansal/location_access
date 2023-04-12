// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class SimpleMapScreen extends StatefulWidget {
//   const SimpleMapScreen({Key? key}) : super(key: key);
//
//   @override
//   _SimpleMapScreenState createState() => _SimpleMapScreenState();
// }
//
// class _SimpleMapScreenState extends State<SimpleMapScreen> {
//   final Completer<GoogleMapController> _controller = Completer();
//
//   static final CameraPosition initialPosition = CameraPosition(
//       target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.0
//   );
//
//   static final CameraPosition targetPosition = CameraPosition(target: LatLng(37.43296265331129, -122.08832357078792), zoom: 14.0, bearing: 192.0, tilt: 60);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Simple Google Map"),
//         centerTitle: true,
//       ),
//       body: GoogleMap(
//         initialCameraPosition: initialPosition,
//         mapType: MapType.normal,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {
//             goToLake();
//           },
//           label: const Text("To the lake!"),
//           icon: const Icon(Icons.directions_boat),
//         ),
//     );
//   }
//
//   Future<void> goToLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMapScreen extends StatefulWidget {
  const SimpleMapScreen({super.key});

  @override
  State<SimpleMapScreen> createState() => _SimpleMapScreenState();
}


class _SimpleMapScreenState extends State<SimpleMapScreen> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  final LatLng _center = const LatLng(45.521563, -122.677433);


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          elevation: 2,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          markers: _markers,

        ),
      ),
    );
  }
}

