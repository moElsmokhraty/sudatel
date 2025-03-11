import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/data/repos/auth_repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepo) : super(LoginInitial());

  final AuthRepo _authRepo;

  Future<void> login() async {
    emit(LoginLoading());
    final result = await _authRepo.login();
    result.fold(
      (failure) => emit(LoginFailure(failure.errMessage)),
      (user) => saveUserToFirestore(user!),
    );
  }

  Future<void> saveUserToFirestore(User user) async {
    final result = await _authRepo.saveUserToFirestore(user);
    result.fold(
      (failure) => emit(LoginFailure(failure.errMessage)),
      (_) => emit(LoginSuccess(user)),
    );
  }
}
