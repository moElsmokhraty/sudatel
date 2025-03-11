import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/home_repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());

  final HomeRepo _homeRepo;

  Future<void> didUserCheckInToday() async {
    emit(DidCheckInLoading());
    final result = await _homeRepo.didUserCheckInToday(
      FirebaseAuth.instance.currentUser!.uid,
    );
    result.fold(
      (failure) => emit(DidCheckInError(failure.errMessage)),
      (isCheckIn) => emit(DidCheckInSuccess(isCheckIn)),
    );
  }

  Future<void> checkInUser() async {
    emit(CheckInUserLoading());
    final result = await _homeRepo.checkInUser(
      FirebaseAuth.instance.currentUser!.uid,
    );
    result.fold(
      (failure) => emit(CheckInUserError(failure.errMessage)),
      (_) => emit(CheckInUserSuccess()),
    );
  }

  Future<void> checkOutUser() async {
    emit(CheckOutUserLoading());
    final result = await _homeRepo.checkOutUser(
      FirebaseAuth.instance.currentUser!.uid,
    );
    result.fold(
      (failure) => emit(CheckOutUserError(failure.errMessage)),
      (_) => emit(CheckOutUserSuccess()),
    );
  }
}
