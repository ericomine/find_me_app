import 'package:find_me_app/features/geolocation/data/data_sources/geolocation_sensor_data_source.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocator_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';

import '../../stubs/position_stub.dart';

class GeolocatorWrapperMock extends Mock implements GeolocatorWrapper {}

void main() {
  late GeolocationSensorDataSource sut;
  late GeolocatorWrapper _geolocator;

  setUp(() {
    _geolocator = GeolocatorWrapperMock();
    sut = GeolocationSensorDataSource(_geolocator);
  });
  test(
    'Should retrieve geolocation from geolocator if permission is granted',
    () async {
      when(() => _geolocator.getCurrentPosition())
          .thenAnswer((_) async => positionStub);

      final geolocation = await sut.getGeolocation();

      verify(() => _geolocator.getCurrentPosition()).called(1);
      expect(geolocation.latitude, positionStub.latitude);
      expect(geolocation.longitude, positionStub.longitude);
      verifyNoMoreInteractions(_geolocator);
    },
  );
}
