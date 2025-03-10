import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sudatel/core/widgets/spinkit.dart';
import '../../../../../../core/di/service_locator.dart';
import '../../../../../../core/service/location_service.dart';
import '../../../../../../core/styles/app_colors.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  HomeMapState createState() => HomeMapState();
}

class HomeMapState extends State<HomeMap> with AutomaticKeepAliveClientMixin {
  GoogleMapController? _controller;
  LatLng? _currentPosition;
  LocationPermission? _permission;
  bool isLocationServiceEnabled = false;

  final LocationService _locationService = getIt.get<LocationService>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _getLocation() async {
    Position position = await _locationService.getCurrentLocation();

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> _checkPermission() async {
    _permission = await _locationService.getLocationPermission();
    if (_permission == LocationPermission.deniedForever ||
        _permission == LocationPermission.denied) {
      _permission = await _locationService.getLocationPermission();
    }
    if (_permission == LocationPermission.whileInUse ||
        _permission == LocationPermission.always) {
      isLocationServiceEnabled =
          await _locationService.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        await _getLocation();
      } else {
        await _locationService.openLocationSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 180.h,
      width: 1.sw,
      child: _currentPosition == null
          ? Center(
              child: SpinKitCircle(
                color: AppColors.darkRed,
                size: 50.0,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _currentPosition!,
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId("current"),
                    position: _currentPosition!,
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
              ),
            ),
    );
  }
}
