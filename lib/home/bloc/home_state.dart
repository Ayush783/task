part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.hasError = false,
    this.isLoading = true,
    this.users = const [],
  });

  final List<User> users;
  final bool isLoading;
  final bool hasError;

  HomeState copyWith(
      {bool hasError = false, bool isLoading = false, List<User>? users}) {
    return HomeState(
      hasError: hasError,
      isLoading: isLoading,
      users: users ?? this.users,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        hasError,
        users,
      ];
}
