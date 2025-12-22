import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../services/location_service.dart';

class LocationController extends GetxController {
  final LocationService _locationService = LocationService();
  StreamSubscription<Position>? _locationSubscription;

  var locationMessage = "Listening to location...".obs;

  @override
  void onInit() {
    super.onInit();
    startTrackingLocation(); // ✅ Start tracking when controller initializes
  }

  void startTrackingLocation() {
    _locationSubscription = _locationService.locationStream.listen(
      (Position position) {
        locationMessage.value =
            "Sajid testing Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      },
      onError: (error) {
        locationMessage.value =
            "GPS is off! Please enable it to continue tracking.";
      },
    );
  }

  void stopTrackingLocation() {
    _locationSubscription?.cancel();
    locationMessage.value = "Stopped listening to location.";
  }

  @override
  void onClose() {
    _locationSubscription?.cancel();
    super.onClose();
  }
}
