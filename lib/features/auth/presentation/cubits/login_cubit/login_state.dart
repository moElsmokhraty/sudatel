part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();
}

final class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

final class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

final class LoginSuccess extends LoginState {
  final User? user;

  const LoginSuccess(this.user);

  @override
  List<User?> get props => [user];
}

final class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);

  @override
  List<String> get props => [message];
}
