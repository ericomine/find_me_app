import 'package:geolocator/geolocator.dart';

abstract class GeolocatorWrapperInterface {
  Future<LocationPermission> checkPermission();
  Future<LocationPermission> requestPermission();
  Future<Position> getCurrentPosition();
  Stream<Position> streamPosition();
}

class GeolocatorWrapper implements GeolocatorWrapperInterface {
  @override
  Future<LocationPermission> checkPermission() {
    return Geolocator.checkPermission();
  }

  @override
  Future<LocationPermission> requestPermission() {
    return Geolocator.requestPermission();
  }

  @override
  Future<Position> getCurrentPosition() {
    return Geolocator.getCurrentPosition();
  }

  @override
  Stream<Position> streamPosition() {
    return Geolocator.getPositionStream();
  }
}
