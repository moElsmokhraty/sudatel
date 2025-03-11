import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_repo.dart';
import 'package:sudatel/core/errors/failure.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<Failure, User?>> login() async {
    try {
      final GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleSignIn!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return Right(userCredential.user);
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
  Future<Either<Failure, void>> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        return Left(Failure('Check your internet connection'));
      } else {
        return Left(Failure('An error occurred'));
      }
    } catch (e) {
      return Left(Failure('An error occurred'));
    }
  }
}
