class CustomException implements Exception {
  const CustomException([
    this.error,
    this.stackTrace,
    this.message = '',
  ]);

  final Object? error;
  final StackTrace? stackTrace;
  final String message;
}

class GeolocationSensorException extends CustomException {
  const GeolocationSensorException([
    Object? error,
    StackTrace? stackTrace,
    String message = '',
  ]) : super(error, stackTrace, message);
}

class GeolocationNoPermissionException extends GeolocationSensorException {
  const GeolocationNoPermissionException([
    Object? error,
    StackTrace? stackTrace,
    String message = '',
  ]) : super(error, stackTrace, message);
}

class GeolocationDisabledException extends GeolocationSensorException {
  const GeolocationDisabledException([
    Object? error,
    StackTrace? stackTrace,
    String message = '',
  ]) : super(error, stackTrace, message);
}
