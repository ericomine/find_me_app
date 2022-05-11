import 'package:either/either.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocator_error.dart';
import 'package:find_me_app/features/geolocation/data/models/geolocation_model.dart';

abstract class GeolocationDataSource {
  Future<Either<GeolocatorError, GeolocationModel>> getGeolocation();
}
