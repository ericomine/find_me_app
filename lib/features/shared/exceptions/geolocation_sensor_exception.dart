class GeolocationSensorException implements Exception {
  const GeolocationSensorException([
    this.error,
    this.stackTrace,
    this.message = '',
  ]);

  final Object? error;
  final StackTrace? stackTrace;
  final String message;
}
