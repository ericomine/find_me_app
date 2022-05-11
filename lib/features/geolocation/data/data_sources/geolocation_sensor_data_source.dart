import 'dart:async';

import 'package:either/either.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocation_data_source.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocator_error.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocator_wrapper.dart';
import 'package:find_me_app/features/geolocation/data/models/geolocation_model.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationSensorDataSource implements GeolocationDataSource {
  const GeolocationSensorDataSource(this._geolocator);

  final GeolocatorWrapper _geolocator;

  @override
  Future<Either<GeolocatorError, GeolocationModel>> getGeolocation() async {
    final permission = await _checkPermission();

    return permission.fold(
      onLeft: (left) async => Left(left),
      onRight: (right) async {
        try {
          final position = await _geolocator.getCurrentPosition();
          final model = GeolocationModel(
            latitude: position.latitude,
            longitude: position.longitude,
          );
          return Right(model);
        } on LocationServiceDisabledException catch (_) {
          return const Left(GeolocatorError.notAvailable);
        } catch (_) {
          return const Left(GeolocatorError.other);
        }
      },
    );
  }

  Future<Either<GeolocatorError, void>> _checkPermission() async {
    final permission = await _geolocator.checkPermission();
    final allowed = permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;

    if (!allowed) {
      return const Left(GeolocatorError.notAllowed);
    }
    return const Right(null);
  }
}
