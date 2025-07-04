import 'package:plotvote/core/failure/failure.dart';
import 'package:plotvote/core/model/either.dart';
import 'package:plotvote/features/auth/domain/model/user_model.dart';

abstract class UserRepo{
  Future<Either<Failure,UserModel>> getUser();
}