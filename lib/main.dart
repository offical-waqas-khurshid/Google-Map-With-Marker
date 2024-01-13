import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class Branch {
  final String name;
  final double latitude;
  final double longitude;
  final String contactNumber;

  Branch({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.contactNumber,
  });
}

class MapController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxSet<Marker> markers = <Marker>{}.obs;
  final List<String> cities = ['City 1', 'City 2', 'City 3'].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with some default markers
    searchBranches('City 1');
  }

  void searchBranches(String cityName) {
    // Simulate fetching branch locations based on the city
    // Replace this with your actual logic to get branch locations
    List<Branch> branches = getBranches(cityName);

    // Clear existing markers
    markers.clear();

    // Add markers for each branch in the selected city
    branches.forEach((branch) {
      markers.add(
        Marker(
          markerId: MarkerId(branch.name),
          position: LatLng(branch.latitude, branch.longitude),
          infoWindow: InfoWindow(
            title: branch.name,
            snippet: branch.contactNumber,
          ),
        ),
      );
    });
    update();
  }

  List<Branch> getBranches(String cityName) {
    // Replace this with your logic to fetch branches from the database or API
    // This is just a dummy function to simulate branch data
    return [
      Branch(name: 'Branch A', latitude: 37.7749, longitude: -122.4194, contactNumber: '123-456-7890'),
      Branch(name: 'Branch B', latitude: 37.7831, longitude: -122.4039, contactNumber: '987-654-3210'),
      // Add more branches as needed
    ];
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
        },
        // onMarkerTapped: (MarkerId markerId) {
        //   // Show a dialog with branch contact information
        //   final tappedBranch = mapController.getBranches(mapController.cities.first)[0];
        //   Get.defaultDialog(
        //     title: tappedBranch.name,
        //     content: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text('Contact Number: ${tappedBranch.contactNumber}'),
        //         // Add more branch details as needed
        //       ],
        //     ),
        //   );
        // },
      ),
    );
  }
}
