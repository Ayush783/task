import 'package:task/home/models/user.dart';
import 'package:task/home/models/user_response.dart';

class UserService {
  Future<UserResponse> getUsers() async =>
      Future.delayed(const Duration(seconds: 3)).then((value) {
        return UserResponse.succes(
          mockUserList
              .map(
                (e) => User(
                  e['name'],
                  e['user_id'],
                ),
              )
              .toList(),
        );
      });
}

const mockUserList = [
  {"name": "User 1", "user_id": "user111"},
  {"name": "User 2", "user_id": "user222"},
  {"name": "User 3", "user_id": "user333"},
  {"name": "User 4", "user_id": "user444"},
  {"name": "User 5", "user_id": "user555"},
  {"name": "User 6", "user_id": "user666"},
];
