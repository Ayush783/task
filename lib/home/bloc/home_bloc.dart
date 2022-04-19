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

    on<AddUser>(_onAddUser);

    on<EditUser>(_onEditUser);

    on<DeleteUser>(_onDeleteUser);
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

  void _onAddUser(AddUser event, Emitter emit) async {
    emit(state.copyWith(isAdding: true));
    await userService.mockManageUser();
    // state.users.add(event.user);
    log(state.users.toString());
    emit(
      state.copyWith(
        users: state.addUser(event.user),
        isAdded: true,
      ),
    );
    log(state.users.toString());
  }

  void _onEditUser(EditUser event, Emitter emit) async {
    emit(state.copyWith(isAdding: true));
    await userService.mockManageUser();
    emit(
      state.copyWith(
        users: state.editUser(event.prevUser, event.newUser),
        isAdded: true,
      ),
    );
  }

  void _onDeleteUser(DeleteUser event, Emitter emit) async {
    emit(
      state.copyWith(
        isDeleting: true,
        deletingIndex: event.index,
      ),
    );
    await userService.mockManageUser();
    state.users.remove(event.user);
    emit(
      state.copyWith(
        users: state.users,
        isDeleted: true,
      ),
    );
  }
}
