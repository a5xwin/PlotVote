import 'package:plotvote/core/failure/failure.dart';
import 'package:plotvote/core/model/either.dart';

abstract class CreateGameRepo {
  Future<Either<Failure, String>> createGame(
      {required String title,
      required int rounds,
      required int roundDuration,
      required int votingDuration,
      required int maximumParticipants});
}

