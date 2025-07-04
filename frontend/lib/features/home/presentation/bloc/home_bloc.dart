import 'package:bloc/bloc.dart';
import 'package:plotvote/features/home/domain/repo/home_repo.dart';
import 'package:plotvote/features/home/presentation/bloc/home_event.dart';
import 'package:plotvote/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepo homeRepo;

  HomeBloc({required this.homeRepo}) : super(HomeState.initial()) {
    on<CheckGameByCodeEvent>(onCheckGameByCodeEvent);
    on<GetCompletedGamesEvent>(onGetCompletedGamesEvent);
    on<GetActiveGamesEvent>(onGetActiveGamesEvent);
  }

  Future onCheckGameByCodeEvent(
      CheckGameByCodeEvent event, Emitter emit) async {
    emit(state.copyWith(status: HomeStatus.checkGameLoading));
    var result = await homeRepo.checkGameByCode(event.gameCode);
    if (result.isRight()) {
      emit(state.copyWith(
          status: HomeStatus.successfullyCheckedGame, gameModel: result.right));
    } else {
      emit(state.copyWith(
          status: HomeStatus.checkGameError, errorMessage: result.left.message));
    }
  }

  Future onGetActiveGamesEvent(GetActiveGamesEvent event, Emitter emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    var result = await homeRepo.getActiveGames();
    if (result.isRight()) {
      emit(state.copyWith(
          status: HomeStatus.success, activeGames: result.right));
    } else {
      emit(state.copyWith(
          status: HomeStatus.error, errorMessage: result.left.message));
    }
  }

  Future onGetCompletedGamesEvent(GetCompletedGamesEvent event, Emitter emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    var result = await homeRepo.getCompletedGames();
    if (result.isRight()) {
      emit(state.copyWith(
          status: HomeStatus.success, completedGames: result.right));
    } else {
      emit(state.copyWith(
          status: HomeStatus.error, errorMessage: result.left.message));
    }
  }
}
