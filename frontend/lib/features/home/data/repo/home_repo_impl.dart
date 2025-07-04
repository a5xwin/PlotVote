import 'package:plotvote/core/failure/failure.dart';
import 'package:plotvote/core/model/either.dart';
import 'package:plotvote/features/game/domain/model/game_model.dart';
import 'package:plotvote/features/home/data/datasource/home_remote_datasource.dart';
import 'package:plotvote/features/home/domain/repo/home_repo.dart';
import 'package:dio/dio.dart';



class HomeRepoImpl implements HomeRepo{
  final HomeRemoteDatasource homeRemoteDatasource;

  HomeRepoImpl({required this.homeRemoteDatasource});

  @override
  Future<Either<Failure, GameModel>> checkGameByCode(String gameCode) async {
    try{
      var result = await homeRemoteDatasource.checkGameByCode(gameCode);
      return Either.right(result);
    }
    on DioException catch (e){
      return Either.left(GameFailure(message: e.response?.data['error']));
    }
    catch (e){
      return Either.left(GameFailure(message: 'Join game failure'));
    }
  }

  @override
  Future<Either<Failure, List<GameModel>>> getActiveGames() async {
    try{
      var games = await homeRemoteDatasource.getGames(isActive: true);
      return Either.right(games);
    }
    on DioException catch (e){
      return Either.left(GameFailure(message: e.response?.data['error']));
    }
    catch (e){
      return Either.left(GameFailure(message: 'Games error'));
    }
  }

  @override
  Future<Either<Failure, List<GameModel>>> getCompletedGames() async {
    try{
      var games = await homeRemoteDatasource.getGames(isActive: false);
      return Either.right(games);
    }
    on DioException catch (e){
      return Either.left(GameFailure(message: e.response?.data['error']));
    }
    catch (e){
      return Either.left(GameFailure(message: 'Games error'));
    }
  }

}