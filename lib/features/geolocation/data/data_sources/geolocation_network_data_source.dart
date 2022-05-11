import 'package:either/either.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocation_data_source.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocator_error.dart';
import 'package:find_me_app/features/geolocation/data/models/geolocation_model.dart';

class GeolocationNetworkDataSource implements GeolocationDataSource {
  @override
  Future<Either<GeolocatorError, GeolocationModel>> getGeolocation() {
    throw UnimplementedError();
  }
}
