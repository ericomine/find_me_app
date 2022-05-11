import 'package:find_me_app/features/geolocation/data/data_sources/geolocation_data_source.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocation_network_data_source.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocation_sensor_data_source.dart';
import 'package:find_me_app/features/geolocation/domain/entities/geolocation.dart';
import 'package:find_me_app/features/geolocation/domain/repositories/geolocation_repository_interface.dart';

class GeolocationRepository implements GeolocationRepositoryInterface {
  GeolocationRepository(this._sensorDataSource, this._networkDataSource);

  final GeolocationSensorDataSource _sensorDataSource;
  final GeolocationNetworkDataSource _networkDataSource;

  @override
  Future<Geolocation> getGeolocation() async {
    return const Geolocation(latitude: 0, longitude: 0);
  }
}
