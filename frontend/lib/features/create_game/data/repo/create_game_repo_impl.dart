import 'package:plotvote/core/failure/failure.dart';
import 'package:plotvote/core/model/either.dart';
import 'package:plotvote/features/create_game/data/datasource/create_game_remote_datasource.dart';
import 'package:plotvote/features/create_game/domain/repo/create_game_repo.dart';
import 'package:dio/dio.dart';

class CreateGameRepoImpl implements CreateGameRepo{
  final CreateGameRemoteDatasource createGameRemoteDatasource;

  CreateGameRepoImpl({required this.createGameRemoteDatasource});

  @override
  Future<Either<Failure, String>> createGame(
      {required String title,
      required int rounds,
      required int roundDuration,
      required int votingDuration,
      required int maximumParticipants}) async {
    try {
      var gameCode = await createGameRemoteDatasource.createGame(
          title: title,
          rounds: rounds,
          roundDuration: roundDuration,
          votingDuration: votingDuration,
          maximumParticipants: maximumParticipants);
      return Either.right(gameCode);
    } on DioException catch (e) {
      return Either.left(CreateGameFailure(message: e.response?.data['error']));
    } catch (e) {
      return Either.left(CreateGameFailure(message: 'Create game error'));
    }
  }
}