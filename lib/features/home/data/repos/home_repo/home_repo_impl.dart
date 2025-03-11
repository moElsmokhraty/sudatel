import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sudatel/core/errors/failure.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  @override
  Future<Either<Failure, bool>> didUserCheckInToday(String uid) async {
    try {
      String today = DateTime.now().toIso8601String().split('T')[0];

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('checkIns')
          .doc(today)
          .get();

      return Right(snapshot.exists);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        return Left(Failure('Check your internet connection'));
      } else {
        return Left(Failure(e.code));
      }
    } catch (e) {
      return Left(Failure('An error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> checkInUser(String userId) async {
    String today = DateTime.now().toIso8601String().split('T')[0];

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('checkIns')
          .doc(today)
          .set({'checkInTime': FieldValue.serverTimestamp()});
      return Right(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        return Left(Failure('Check your internet connection'));
      } else {
        return Left(Failure(e.code));
      }
    } catch (e) {
      return Left(Failure('An error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> checkOutUser(String userId) async {
    try {
      String today = DateTime.now().toIso8601String().split('T')[0];

      DocumentReference checkInRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('checkIns')
          .doc(today);

      await checkInRef.update({'checkOutTime': FieldValue.serverTimestamp()});
      return Right(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        return Left(Failure('Check your internet connection'));
      } else {
        return Left(Failure(e.code));
      }
    } catch (e) {
      return Left(Failure('An error occurred'));
    }
  }
}
