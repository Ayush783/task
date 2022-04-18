import 'package:task/home/models/user.dart';

class UserResponse {
  final List<User>? users;
  final bool error;
  final String errorMessage;

  UserResponse(
      {this.users, this.error = false, this.errorMessage = 'NO_ERROR'});

  UserResponse.succes(List<User> data)
      : users = data,
        error = false,
        errorMessage = 'NO_ERROR';
  UserResponse.failure(String msg)
      : users = [],
        error = true,
        errorMessage = msg;
}
