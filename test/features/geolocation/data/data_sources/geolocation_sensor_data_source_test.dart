import 'package:find_me_app/features/geolocation/data/data_sources/geolocation_sensor_data_source.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocator_error.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocator_wrapper.dart';
import 'package:flutter/services.dart';
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
      when(() => _geolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.whileInUse);
      when(() => _geolocator.getCurrentPosition())
          .thenAnswer((_) async => positionStub);

      final result = await sut.getGeolocation();

      result.fold(
        onLeft: (_) => fail('Unexpected error'),
        onRight: (geolocation) {
          expect(geolocation.latitude, positionStub.latitude);
          expect(geolocation.longitude, positionStub.longitude);
        },
      );
      verify(() => _geolocator.checkPermission()).called(1);
      verify(() => _geolocator.getCurrentPosition()).called(1);
      verifyNoMoreInteractions(_geolocator);
    },
  );

  test(
    'Should return GeolocatorError.notAllowed if permission is denied',
    () async {
      when(() => _geolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.denied);

      final result = await sut.getGeolocation();

      result.fold(
        onLeft: (error) => expect(error, GeolocatorError.notAllowed),
        onRight: (_) => fail('Unexpected success'),
      );

      verify(() => _geolocator.checkPermission()).called(1);
      verifyNever(() => _geolocator.getCurrentPosition());
      verifyNoMoreInteractions(_geolocator);
    },
  );

  test(
    'Should return GeolocatorError.notAvailable if permission is granted, '
    'but sensor is disabled',
    () async {
      when(() => _geolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);
      when(() => _geolocator.getCurrentPosition())
          .thenThrow(const LocationServiceDisabledException());

      final result = await sut.getGeolocation();

      result.fold(
        onLeft: (error) => expect(error, GeolocatorError.notAvailable),
        onRight: (_) => fail('Unexpected success'),
      );

      verify(() => _geolocator.checkPermission()).called(1);
      verify(() => _geolocator.getCurrentPosition()).called(1);
      verifyNoMoreInteractions(_geolocator);
    },
  );

  test(
    'Should return GeolocatorError.other when generic exception occurs',
    () async {
      when(() => _geolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);
      when(() => _geolocator.getCurrentPosition())
          .thenThrow(PlatformException(code: 'ERROR'));

      final result = await sut.getGeolocation();

      result.fold(
        onLeft: (error) => expect(error, GeolocatorError.other),
        onRight: (_) => fail('Unexpected success'),
      );

      verify(() => _geolocator.checkPermission()).called(1);
      verify(() => _geolocator.getCurrentPosition()).called(1);
      verifyNoMoreInteractions(_geolocator);
    },
  );
}
