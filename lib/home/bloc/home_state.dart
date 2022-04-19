part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.hasError = false,
    this.isLoading = true,
    this.isDeleting = false,
    this.isAdding = false,
    this.deletingIndex = -1,
    this.users = const [],
  });

  final List<User> users;
  final bool isLoading;
  final bool hasError;
  final bool isDeleting;
  final int deletingIndex;
  final bool isAdding;

  HomeState copyWith({
    bool hasError = false,
    bool isLoading = false,
    List<User>? users,
    bool isAdding = false,
    bool isDeleting = false,
    int deletingIndex = -1,
  }) {
    return HomeState(
      hasError: hasError,
      isLoading: isLoading,
      users: users ?? this.users,
      isAdding: isAdding,
      isDeleting: isDeleting,
      deletingIndex: deletingIndex,
    );
  }

  List<User> deleteUser(User user) {
    users.remove(user);
    return users;
  }

  @override
  List<Object> get props => [
        isLoading,
        hasError,
        users,
        isAdding,
        isDeleting,
        deletingIndex,
      ];
}
