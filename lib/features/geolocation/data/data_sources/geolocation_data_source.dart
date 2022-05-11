import 'package:find_me_app/features/geolocation/data/models/geolocation_model.dart';

abstract class GeolocationDataSource {
  Future<GeolocationModel> getGeolocation();
}
