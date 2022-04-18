part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.hasError = false,
    this.isAuthorized = false,
    this.isLoading = false,
    this.showPassword = false,
  });

  final bool hasError;
  final bool isAuthorized;
  final bool isLoading;
  final bool showPassword;

  AuthState copyWith({
    bool hasError = false,
    bool isAuthorized = false,
    bool isLoading = false,
    bool showPassword = false,
  }) {
    return AuthState(
      hasError: hasError,
      isAuthorized: isAuthorized,
      isLoading: isLoading,
      showPassword: showPassword,
    );
  }

  @override
  List<Object> get props => [
        hasError,
        isAuthorized,
        isLoading,
        showPassword,
      ];
}
