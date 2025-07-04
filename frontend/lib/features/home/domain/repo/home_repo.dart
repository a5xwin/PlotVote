import 'package:plotvote/core/failure/failure.dart';
import 'package:plotvote/core/model/either.dart';
import 'package:plotvote/features/game/domain/model/game_model.dart';

abstract class HomeRepo{
  Future<Either<Failure,GameModel>> checkGameByCode(String gameCode);

  Future<Either<Failure,List<GameModel>>> getActiveGames();

  Future<Either<Failure,List<GameModel>>> getCompletedGames();
}