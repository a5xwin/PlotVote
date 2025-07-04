import 'package:plotvote/core/api/api_client.dart';
import 'package:plotvote/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:plotvote/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:plotvote/features/auth/data/repo/auth_repo_impl.dart';
import 'package:plotvote/features/auth/data/repo/user_repo_impl.dart';
import 'package:plotvote/features/auth/domain/repo/auth_repo.dart';
import 'package:plotvote/features/auth/domain/repo/user_repo.dart';
import 'package:plotvote/features/auth/presentation/bloc/user_bloc.dart';
import 'package:plotvote/features/create_game/data/datasource/create_game_remote_datasource.dart';
import 'package:plotvote/features/create_game/data/repo/create_game_repo_impl.dart';
import 'package:plotvote/features/create_game/domain/repo/create_game_repo.dart';
import 'package:plotvote/features/create_game/presentation/bloc/create_game_bloc.dart';
import 'package:plotvote/features/game/data/datasource/game_remote_datasource.dart';
import 'package:plotvote/features/game/data/repo/game_repo_impl.dart';
import 'package:plotvote/features/game/domain/repo/game_repo.dart';
import 'package:plotvote/features/game/presentation/bloc/game_bloc.dart';
import 'package:plotvote/features/home/data/datasource/home_remote_datasource.dart';
import 'package:plotvote/features/home/data/repo/home_repo_impl.dart';
import 'package:plotvote/features/home/domain/repo/home_repo.dart';
import 'package:plotvote/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  registerApiClient();
  registerDatasource();
  registerRepo();
  registerBloc();
}

void registerApiClient() {
  getIt.registerSingleton(ApiClient());
}

void registerDatasource() {
  var dio = getIt<ApiClient>().getDio();
  var dioWithTokenInterceptor =
      getIt<ApiClient>().getDio(tokenInterceptor: true);

  getIt.registerSingleton(AuthRemoteDatasource(dio: dio));
  getIt.registerSingleton(UserRemoteDatasource(dio: dioWithTokenInterceptor));
  getIt.registerSingleton(
      CreateGameRemoteDatasource(dio: dioWithTokenInterceptor));
  getIt.registerSingleton(GameRemoteDatasource());
  getIt.registerSingleton(HomeRemoteDatasource(dio: dioWithTokenInterceptor));
}

void registerRepo() {
  getIt.registerSingleton<AuthRepo>(
      AuthRepoImpl(authRemoteDatasource: getIt()));
  getIt.registerSingleton<UserRepo>(
      UserRepoImpl(userRemoteDatasource: getIt()));
  getIt.registerSingleton<CreateGameRepo>(
      CreateGameRepoImpl(createGameRemoteDatasource: getIt()));
  getIt.registerSingleton<GameRepo>(
      GameRepoImpl(gameRemoteDatasource: getIt()));
  getIt.registerSingleton<HomeRepo>(
      HomeRepoImpl(homeRemoteDatasource: getIt()));
}

void registerBloc() {
  getIt.registerFactory(
      () => UserBloc(authRepo: getIt(), userRepo: getIt()));

  getIt.registerFactory(() => CreateGameBloc(createGameRepo: getIt()));

  getIt.registerFactory(() => GameBloc(gameRepo: getIt()));

  getIt.registerFactory(() => HomeBloc(homeRepo: getIt()));
}