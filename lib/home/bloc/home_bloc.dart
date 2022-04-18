import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task/home/models/user.dart';
import 'package:task/home/service/user_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LoadUsers>(_onLoadUsers);
  }

  final UserService userService = UserService();

  void _onLoadUsers(LoadUsers event, Emitter emit) async {
    emit(
      state.copyWith(isLoading: true),
    );
    final userResponse = await userService.getUsers();
    log(userResponse.users!.length.toString());
    if (userResponse.error) {
      emit(state.copyWith(hasError: true));
    } else {
      emit(state.copyWith(users: userResponse.users));
    }
  }
}
