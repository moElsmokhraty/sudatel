import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, bool>> didUserCheckInToday(String uid);

  Future<Either<Failure, void>> checkInUser(String uid);

  Future<Either<Failure, void>> checkOutUser(String uid);
}
