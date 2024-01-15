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

  MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        actions: [
          PopupMenuButton<MapType>(
            onSelected: (selectedMapType) {
              mapController.changeMapType(selectedMapType);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<MapType>(
                  value: MapType.normal,
                  child: Text('Normal'),
                ),
                const PopupMenuItem<MapType>(
                  value: MapType.satellite,
                  child: Text('Satellite'),
                ),
                const PopupMenuItem<MapType>(
                  value: MapType.hybrid,
                  child: Text('Hybrid'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Obx(
        () {
          return GoogleMap(
            mapType: mapController.selectedMapType.value,
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 12.0,
            ),
            markers: mapController.markers.toSet(),
            onMapCreated: (GoogleMapController controller) {
              /// You can use the controller for further map customization
            },
            onTap: (LatLng latLng) {
              /// Close any existing dialogs when tapping on the map
              Get.back();
              /// Find the tapped marker based on its position
              final tappedMarker = mapController.markers.firstWhere(
                    (marker) => marker.position == latLng,
              );

              final tappedBranch = mapController.getBranches(mapController.mapType.first)[0];
              Get.defaultDialog(
                title: tappedBranch.name,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contact Number: ${tappedBranch.contactNumber}'),
                    Text('Contact Number: ${tappedBranch.contactNumber}'),
                  ],
                ),
              );
              },
          );
        }
      ),
    );
  }
}
