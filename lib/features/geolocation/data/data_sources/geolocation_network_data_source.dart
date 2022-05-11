import 'package:find_me_app/features/geolocation/data/data_sources/geolocation_data_source.dart';
import 'package:find_me_app/features/geolocation/data/models/geolocation_model.dart';

class GeolocationNetworkDataSource implements GeolocationDataSource {
  @override
  Future<GeolocationModel> getGeolocation() {
    throw UnimplementedError();
  }
}
