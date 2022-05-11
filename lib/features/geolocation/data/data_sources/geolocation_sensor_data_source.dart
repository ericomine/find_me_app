import 'dart:async';

import 'package:find_me_app/features/geolocation/data/data_sources/geolocation_data_source.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocator_wrapper.dart';
import 'package:find_me_app/features/geolocation/data/models/geolocation_model.dart';
import 'package:find_me_app/features/shared/exceptions/geolocation_exceptions.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationSensorDataSource implements GeolocationDataSource {
  const GeolocationSensorDataSource(this._geolocator);

  final GeolocatorWrapper _geolocator;

  @override
  Future<GeolocationModel> getGeolocation() async {
    try {
      await _checkPermission();

      final position = await _geolocator.getCurrentPosition();
      final model = GeolocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      return model;
    } on GeolocationNoPermissionException {
      rethrow;
    } on LocationServiceDisabledException catch (error, stackTrace) {
      throw GeolocationDisabledException(error, stackTrace);
    } catch (error, stackTrace) {
      throw GeolocationSensorException(error, stackTrace);
    }
  }

  Future<void> _checkPermission() async {
    final permission = await _geolocator.checkPermission();
    final allowed = permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
    if (!allowed) {
      throw const GeolocationNoPermissionException();
    }
  }
}
