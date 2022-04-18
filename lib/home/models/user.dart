import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? username;
  final String? userId;

  const User(this.username, this.userId);

  @override
  List<Object?> get props => [userId, username];
}
