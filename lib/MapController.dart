import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/Branch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxSet<Marker> markers = <Marker>{}.obs;
  final List<String> cities = ['City 1', 'City 2', 'City 3'].obs;

  @override
  void onInit() {
    super.onInit();
    /// Initialize with some default markers
    searchBranches('City 1');
  }

  void searchBranches(String cityName) {
    /// Simulate fetching branch locations based on the city
    /// Replace this with your actual logic to get branch locations
    List<Branch> branches = getBranches(cityName);
    /// Clear existing markers
    markers.clear();
    /// Add markers for each branch in the selected city
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
    /// Replace this with your logic to fetch branches from the database or API
    /// This is just a dummy function to simulate branch data
    return [
      Branch(name: 'Branch A', latitude: 37.7749, longitude: -122.4194, contactNumber: '123-456-7890'),
      Branch(name: 'Branch B', latitude: 37.7831, longitude: -122.4039, contactNumber: '987-654-3210'),
      Branch(name: 'Branch C', latitude: 37.7841, longitude: -122.4539, contactNumber: '987-654-3210'),
      Branch(name: 'Branch E', latitude: 37.7867, longitude: -122.4089, contactNumber: '987-654-3210'),
    ];
  }
}
