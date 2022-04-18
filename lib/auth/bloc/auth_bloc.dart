import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task/auth/service/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<Login>(_onLogin);
    on<ToggleShowPassword>(_onToggleShowPassword);
  }

  final AuthService _authService = AuthService();

  void _onLogin(Login event, Emitter emit) async {
    emit(
      state.copyWith(isLoading: true),
    );
    final authResponse = await _authService.login(
      userName: event.userName,
      password: event.password,
    );
    if (authResponse.error!) {
      emit(
        state.copyWith(hasError: true),
      );
    } else {
      emit(
        state.copyWith(isAuthorized: true),
      );
    }
  }

  void _onToggleShowPassword(ToggleShowPassword event, Emitter emit) async {
    emit(
      state.copyWith(
        showPassword: !state.showPassword,
      ),
    );
  }
}
