import 'package:find_me_app/features/geolocation/data/repositories/geolocation_repository.dart';
import 'package:find_me_app/features/geolocation/domain/entities/geolocation.dart';

abstract class GeolocationRepositoryInterface {
  Future<Geolocation> getGeolocation();
}
