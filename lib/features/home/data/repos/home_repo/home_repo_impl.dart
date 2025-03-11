import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:sudatel/core/errors/failure.dart';
import 'package:sudatel/features/home/data/models/check_in_and_out_times_model.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  @override
  Future<Either<Failure, bool>> didUserCheckInToday() async {
    try {
      String today = DateTime.now().toIso8601String().split('T')[0];

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
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
  Future<Either<Failure, void>> checkInUser() async {
    String today = DateTime.now().toIso8601String().split('T')[0];

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
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
  Future<Either<Failure, void>> checkOutUser() async {
    try {
      String today = DateTime.now().toIso8601String().split('T')[0];

      DocumentReference checkInRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
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

  @override
  Future<Either<Failure, CheckInAndOutTimesModel>>
      getCheckInAndOutTimes() async {
    try {
      String today = DateTime.now().toIso8601String().split('T')[0];

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('checkIns')
          .doc(today)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data == null) {
          return Right(CheckInAndOutTimesModel());
        }
        Timestamp? checkInTime = snapshot['checkInTime'];
        Timestamp? checkOutTime =
            data.containsKey('checkOutTime') ? snapshot['checkOutTime'] : null;

        DateFormat format = DateFormat('hh:mm a');

        String? formattedCheckIn =
            checkInTime != null ? format.format(checkInTime.toDate()) : null;

        String? formattedCheckOut =
            checkOutTime != null ? format.format(checkOutTime.toDate()) : null;
        return Right(CheckInAndOutTimesModel(
          checkInTime: formattedCheckIn,
          checkOutTime: formattedCheckOut,
        ));
      } else {
        return Right(CheckInAndOutTimesModel());
      }
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
