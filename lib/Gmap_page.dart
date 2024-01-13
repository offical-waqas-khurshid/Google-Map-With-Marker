import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'MapController.dart';

class MapScreen extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps with GetX'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Set your initial position
          zoom: 12.0,
        ),
        markers: mapController.markers.toSet(),
        onMapCreated: (GoogleMapController controller) {
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController.addMarker(37.7749, -122.4194, 'Marker 1');
          mapController.addMarker(37.7831, -122.4039, 'Marker 2');
          // Add more markers as needed
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
