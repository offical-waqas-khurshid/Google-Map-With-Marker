import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/MapController.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MapScreen(),
    );
  }
}





class MapScreen extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: mapController.searchController,
          decoration: InputDecoration(
            hintText: 'Search for a city',
          ),
          onSubmitted: (value) {
            mapController.searchBranches(value);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (selectedCity) {
              mapController.searchBranches(selectedCity);
            },
            itemBuilder: (BuildContext context) {
              return mapController.cities.map((city) {
                return PopupMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 12.0,
        ),
        markers: mapController.markers.toSet(),
        onMapCreated: (GoogleMapController controller) {
          // You can use the controller for further map customization
        },
        onTap: (LatLng latLng) {
          // Close any existing dialogs when tapping on the map
          Get.back();
          // Find the tapped marker based on its position
          final tappedMarker = mapController.markers.firstWhere(
                (marker) => marker.position == latLng,
          );

          if (tappedMarker != null) {
            // Show a dialog with branch contact information
            final tappedBranch = mapController.getBranches(mapController.cities.first)[0];
            Get.defaultDialog(
              title: tappedBranch.name,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Number: ${tappedBranch.contactNumber}'),
                  // Add more branch details as needed
                ],
              ),
            );
          }
          },
      ),
    );
  }
}
