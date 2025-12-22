import 'package:geolocator/geolocator.dart';

class LocationService {
  // Remove _locationSubscription and startListening/stopListening methods

  Stream<Position> get locationStream => Geolocator.getPositionStream(
    locationSettings: LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 10,
    ),
  );
}
