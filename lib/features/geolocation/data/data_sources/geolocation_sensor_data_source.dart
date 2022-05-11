import 'package:find_me_app/features/geolocation/data/data_sources/geolocation_data_source.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocator_wrapper.dart';
import 'package:find_me_app/features/geolocation/data/models/geolocation_model.dart';
import 'package:find_me_app/features/shared/exceptions/geolocation_sensor_exception.dart';

class GeolocationSensorDataSource implements GeolocationDataSource {
  const GeolocationSensorDataSource(this._geolocator);

  final GeolocatorWrapper _geolocator;

  @override
  Future<GeolocationModel> getGeolocation() async {
    try {
      final position = await _geolocator.getCurrentPosition();
      final model = GeolocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      return model;
    } catch (error, stackTrace) {
      throw GeolocationSensorException(error, stackTrace);
    }
  }
}
