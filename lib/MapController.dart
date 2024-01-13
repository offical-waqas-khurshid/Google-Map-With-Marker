import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  final markers = <Marker>[];

  void addMarker(double lat, double lng, String title) {
    markers.add(
      Marker(
        markerId: MarkerId(title),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: title),
      ),
    );
    update();
  }
}
