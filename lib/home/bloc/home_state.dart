part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.hasError = false,
    this.isLoading = true,
    this.isDeleting = false,
    this.isAdding = false,
    this.deletingIndex = -1,
    this.users = const [],
    this.isAdded = false,
    this.isDeleted = false,
  });

  final List<User> users;
  final bool isLoading;
  final bool hasError;
  final bool isDeleting;
  final int deletingIndex;
  final bool isAdding;
  final bool isDeleted;
  final bool isAdded;

  HomeState copyWith({
    bool hasError = false,
    bool isLoading = false,
    List<User>? users,
    bool isAdding = false,
    bool isAdded = false,
    bool isDeleting = false,
    bool isDeleted = false,
    int deletingIndex = -1,
  }) {
    return HomeState(
      hasError: hasError,
      isLoading: isLoading,
      users: users ?? this.users,
      isAdding: isAdding,
      isDeleting: isDeleting,
      deletingIndex: deletingIndex,
      isAdded: isAdded,
      isDeleted: isDeleted,
    );
  }

  List<User> addUser(User user) {
    List<User> _users = List.from(users);
    _users.add(user);
    return _users;
  }

  List<User> editUser(User prevUser, User newuser) {
    List<User> _users = List.from(users);
    _users[_users.indexOf(prevUser)] = newuser;
    return _users;
  }

  @override
  List<Object> get props => [
        isLoading,
        hasError,
        users,
        isAdding,
        isDeleting,
        deletingIndex,
        isAdded,
        isDeleted,
      ];
}
