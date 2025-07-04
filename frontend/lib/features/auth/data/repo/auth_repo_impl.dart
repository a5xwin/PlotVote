import 'package:plotvote/core/failure/failure.dart';
import 'package:plotvote/core/model/either.dart';
import 'package:plotvote/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:plotvote/features/auth/domain/model/user_model.dart';
import 'package:plotvote/features/auth/domain/repo/auth_repo.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepoImpl implements AuthRepo{
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepoImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, UserModel>> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final firebaseCredentials =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final firebaseToken = await firebaseCredentials.user?.getIdToken();

      final request =
      await authRemoteDatasource.loginWithGoogle(firebaseToken!);

      return Either.right(request);
    } on DioException catch (e) {
      return Either.left(AuthFailure(message: e.response?.data['error']));
    } on Exception {
      return Either.left(AuthFailure(message: 'Auth failure'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try{
      await FirebaseAuth.instance.signOut();
      return Either.right(0);
    }
    catch (e){
      return Either.left(AuthFailure(message: 'Logout error'));
    }
  }
}