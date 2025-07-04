import 'package:bloc/bloc.dart';
import 'package:plotvote/features/create_game/domain/repo/create_game_repo.dart';
import 'package:plotvote/features/create_game/presentation/bloc/create_game_event.dart';
import 'package:plotvote/features/create_game/presentation/bloc/create_game_state.dart';

class CreateGameBloc extends Bloc<CreateGameEvent, CreateGameState> {
  final CreateGameRepo createGameRepo;

  CreateGameBloc({required this.createGameRepo})
      : super(CreateGameState.initial()){
    on<CreateGameEvent>(onCreateGameEvent);
  }

  Future onCreateGameEvent(CreateGameEvent event, Emitter emit) async {
    emit(state.copyWith(status: CreateGameStatus.loading));
    var result = await createGameRepo.createGame(
        title: event.title,
        rounds: event.rounds,
        roundDuration: event.roundDuration,
        votingDuration: event.votingDuration,
        maximumParticipants: event.maximumParticipants);

    if (result.isRight()) {
      emit(state.copyWith(
          status: CreateGameStatus.success, createdGameCode: result.right));
    } else {
      emit(state.copyWith(status: CreateGameStatus.error));
    }
  }
}