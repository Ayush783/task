class AuthResponse {
  final bool? error;
  final String errorMessage;

  AuthResponse({this.error, this.errorMessage = 'NO_ERROR'});

  AuthResponse.success()
      : error = false,
        errorMessage = 'NO_ERROR';

  AuthResponse.failure({String? errorMessage})
      : error = true,
        errorMessage = errorMessage!;
}
