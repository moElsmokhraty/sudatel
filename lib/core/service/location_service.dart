import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    );
  }

  Future<LocationPermission> getLocationPermission() async {
    return await Geolocator.requestPermission();
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<LocationPermission> isLocationPermissionGranted() async {
    return await Geolocator.checkPermission();
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  bool isWithinAllowedDistance(
    double userLat,
    double userLng,
  ) {
    double distanceInMeters = Geolocator.distanceBetween(
      userLat,
      userLng,
      29.97266577911208,
      31.236150596112875,
    );

    return distanceInMeters <= 100;
  }
}
