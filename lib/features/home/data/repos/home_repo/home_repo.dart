import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../models/check_in_and_out_times_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, bool>> didUserCheckInToday();

  Future<Either<Failure, void>> checkInUser();

  Future<Either<Failure, void>> checkOutUser();

  Future<Either<Failure, CheckInAndOutTimesModel>> getCheckInAndOutTimes();
}
