part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  final String? userName;
  final String? password;

  const Login(this.userName, this.password);
}

class ToggleShowPassword extends AuthEvent {}
