import 'package:task/auth/models/auth_response.dart';

class AuthService {
  //login method
  Future<AuthResponse> login({String? userName, String? password}) async =>
      Future.delayed(const Duration(seconds: 3)).then(
        (value) {
          if (userName == 'admin' && password == 'admin') {
            return AuthResponse.success();
          } else {
            return AuthResponse.failure(
                errorMessage: 'Invalid username and password');
          }
        },
      );
}
