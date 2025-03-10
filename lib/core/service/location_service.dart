import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
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
    double workLat,
    double workLng,
  ) {
    double distanceInMeters = Geolocator.distanceBetween(
      userLat,
      userLng,
      workLat,
      workLng,
    );

    return distanceInMeters <= 100;
  }
}
