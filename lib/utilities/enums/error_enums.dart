enum ErrorCodes {
  API_ERROR('API Error Occurred'),
  STAND_BY('Standing by'),
  HANDLING_ERROR('Error Handling needed'),
  API_SUCCESS('Success');

  const ErrorCodes(this.message);
  final String message;
}
