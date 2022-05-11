import 'package:find_me_app/features/geolocation/domain/entities/geolocation.dart';

class GeolocationModel {
  const GeolocationModel({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  Geolocation toEntity() =>
      Geolocation(latitude: latitude, longitude: longitude);
}
