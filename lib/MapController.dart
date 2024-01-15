import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_map/Branch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final RxSet<Marker> markers = <Marker>{}.obs;
  final List<String> mapType = ['Normal', 'Satellite', 'Hybrid'].obs;
  BitmapDescriptor? myMarker;
  Rx<MapType> selectedMapType = MapType.normal.obs;

  /// Change Map Type
  void changeMapType(MapType newMapType) {
    selectedMapType.value = newMapType;
  }
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
    if (branches.isNotEmpty) {
      branches.forEach((branch) async {
        markers.add(
          Marker(
            markerId: MarkerId(branch.name),
            position: LatLng(branch.latitude, branch.longitude),
            icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(devicePixelRatio: 2.5),
              'assets/logo/bank.png', // Replace with your image path
            ),
            onTap: () {
              showCustomInfoWindow(branch);
            },
            // infoWindow: InfoWindow(
            //   title: branch.name,
            //   snippet: branch.contactNumber,
            // ),
          ),
        );
      });
      update();
    }
  }

  /// Custom Info Window for marker
  void showCustomInfoWindow(Branch branch) {
    Clipboard.setData(ClipboardData(text: branch.name));
    Clipboard.setData(ClipboardData(text: branch.contactNumber));
    Clipboard.setData(ClipboardData(text: branch.address));
    Get.defaultDialog(
      title: branch.name,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/logo/bank.png', // Replace with your logo image path
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 13,
                          color: Colors.blue,
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'MFSYS Technologies',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.phone, // Replace with your desired icon
                          size: 13,
                          color: Colors.blue,
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            '(051) 41021712',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  /// Branches List
  List<Branch> getBranches(String cityName) {
    /// Replace this with your logic to fetch branches from the database or API
    /// This is just a dummy function to simulate branch data
    return [
      Branch(
          name: 'MFSYS Technolog',
          latitude: 37.7749,
          longitude: -122.4194,
          contactNumber: '123-456-7890',
          address: "Main Branch I9/3"),
      Branch(
          name: 'MFSYS Technolog',
          latitude: 37.7831,
          longitude: -122.4039,
          contactNumber: '987-654-3210',
          address: "Main Branch I9/3"),
      Branch(
          name: 'MFSYS Technolog',
          latitude: 37.7841,
          longitude: -122.4539,
          contactNumber: '987-654-3210',
          address: "Main Branch I9/3"),
      Branch(
          name: 'Branch E',
          latitude: 37.7867,
          longitude: -122.4089,
          contactNumber: '987-654-3210',
          address: "Main Branch I9/3"),
    ];
  }
}
