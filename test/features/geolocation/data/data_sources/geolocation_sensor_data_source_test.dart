import 'package:find_me_app/features/geolocation/data/data_sources/geolocation_sensor_data_source.dart';
import 'package:find_me_app/features/geolocation/data/data_sources/geolocator_wrapper.dart';
import 'package:find_me_app/features/shared/exceptions/geolocation_exceptions.dart';
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

      final geolocation = await sut.getGeolocation();

      verify(() => _geolocator.checkPermission()).called(1);
      verify(() => _geolocator.getCurrentPosition()).called(1);
      expect(geolocation.latitude, positionStub.latitude);
      expect(geolocation.longitude, positionStub.longitude);
      verifyNoMoreInteractions(_geolocator);
    },
  );

  test(
    'Should throw GeolocationNoPermissionException if permission is denied',
    () async {
      when(() => _geolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.denied);

      expect(
        () async => sut.getGeolocation(),
        throwsA(const TypeMatcher<GeolocationNoPermissionException>()),
      );

      verify(() => _geolocator.checkPermission()).called(1);
      verifyNever(() => _geolocator.getCurrentPosition());
      verifyNoMoreInteractions(_geolocator);
    },
  );

  test(
    'Should throw GeolocationDisabledException if permission is granted, '
    'but sensor is disabled',
    () async {
      when(() => _geolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);
      when(() => _geolocator.getCurrentPosition())
          .thenThrow(const LocationServiceDisabledException());

      expect(
        () async => sut.getGeolocation(),
        throwsA(const TypeMatcher<GeolocationDisabledException>()),
      );

      verify(() => _geolocator.checkPermission()).called(1);
      verifyNever(() => _geolocator.getCurrentPosition());
      verifyNoMoreInteractions(_geolocator);
    },
  );

  test(
    'Should throw GeolocationSensorException when generic exception occurs',
    () async {
      when(() => _geolocator.checkPermission())
          .thenAnswer((_) async => LocationPermission.always);
      when(() => _geolocator.getCurrentPosition())
          .thenThrow(PlatformException(code: 'ERROR'));

      expect(
        () async => sut.getGeolocation(),
        throwsA(const TypeMatcher<GeolocationSensorException>()),
      );

      verify(() => _geolocator.checkPermission()).called(1);
      verifyNever(() => _geolocator.getCurrentPosition());
      verifyNoMoreInteractions(_geolocator);
    },
  );
}
