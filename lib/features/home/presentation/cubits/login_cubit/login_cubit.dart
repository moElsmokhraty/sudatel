import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/auth_repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepo) : super(LoginInitial());

  final AuthRepo _authRepo;

  Future<void> login() async {
    emit(LoginLoading());
    final result = await _authRepo.login();
    result.fold(
      (failure) => emit(LoginFailure(failure.errMessage)),
      (user) => emit(LoginSuccess(user)),
    );
  }
}
