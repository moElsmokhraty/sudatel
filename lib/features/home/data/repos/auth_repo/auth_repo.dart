import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, User?>> login();

  Future<Either<Failure, void>> logout();
}
