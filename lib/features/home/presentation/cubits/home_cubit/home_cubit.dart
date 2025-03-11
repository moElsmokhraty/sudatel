import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/home_repo/home_repo.dart';
import '../../../data/models/check_in_and_out_times_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());

  final HomeRepo _homeRepo;

  Future<void> didUserCheckInToday() async {
    emit(DidCheckInLoading());
    final result = await _homeRepo.didUserCheckInToday();
    result.fold(
      (failure) => emit(DidCheckInError(failure.errMessage)),
      (isCheckIn) => emit(DidCheckInSuccess(isCheckIn)),
    );
  }

  Future<void> checkInUser() async {
    emit(CheckInUserLoading());
    final result = await _homeRepo.checkInUser();
    result.fold(
      (failure) => emit(CheckInUserError(failure.errMessage)),
      (_) => emit(CheckInUserSuccess()),
    );
  }

  Future<void> checkOutUser() async {
    emit(CheckOutUserLoading());
    final result = await _homeRepo.checkOutUser();
    result.fold(
      (failure) => emit(CheckOutUserError(failure.errMessage)),
      (_) => emit(CheckOutUserSuccess()),
    );
  }

  Future<void> getCheckInAndOutTimes() async {
    emit(GetCheckInAndOutTimesLoading());
    final result = await _homeRepo.getCheckInAndOutTimes();
    result.fold(
      (failure) => emit(GetCheckInAndOutTimesError(failure.errMessage)),
      (checkInAndOutTimes) => emit(
        GetCheckInAndOutTimesSuccess(checkInAndOutTimes),
      ),
    );
  }
}
