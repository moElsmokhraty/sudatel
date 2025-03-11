part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

final class DidCheckInLoading extends HomeState {
  @override
  List<Object> get props => [];
}

final class DidCheckInError extends HomeState {
  final String errorMessage;

  const DidCheckInError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class DidCheckInSuccess extends HomeState {
  final bool isCheckIn;

  const DidCheckInSuccess(this.isCheckIn);

  @override
  List<Object> get props => [isCheckIn];
}

final class CheckInUserLoading extends HomeState {
  @override
  List<Object> get props => [];
}

final class CheckInUserError extends HomeState {
  final String errorMessage;

  const CheckInUserError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class CheckInUserSuccess extends HomeState {
  @override
  List<Object> get props => [];
}

final class CheckOutUserLoading extends HomeState {
  @override
  List<Object> get props => [];
}

final class CheckOutUserError extends HomeState {
  final String errorMessage;

  const CheckOutUserError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class CheckOutUserSuccess extends HomeState {
  @override
  List<Object> get props => [];
}
