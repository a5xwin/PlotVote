import 'package:plotvote/core/failure/failure.dart';
import 'package:plotvote/core/model/either.dart';
import 'package:plotvote/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:plotvote/features/auth/domain/model/user_model.dart';
import 'package:plotvote/features/auth/domain/repo/user_repo.dart';
import 'package:dio/dio.dart';

class UserRepoImpl implements UserRepo{
  final UserRemoteDatasource userRemoteDatasource;

  UserRepoImpl({required this.userRemoteDatasource});

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    try {
      return Either.right(await userRemoteDatasource.getUser());
    }
    on DioException catch (e){
      return Either.left(AuthFailure(message: e.response?.data['error']));
    }
    catch (e) {
      return Either.left(AuthFailure(message: 'Authorization error'));
    }
  }
}