part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends HomeEvent {}

class AddUser extends HomeEvent {
  final User user;

  const AddUser(this.user);
}

class EditUser extends HomeEvent {
  final User prevUser, newUser;

  const EditUser(this.prevUser, this.newUser);
}

class DeleteUser extends HomeEvent {
  final User user;
  final int index;

  const DeleteUser(this.user, this.index);
}
