//di= dependency injection
import 'package:plotvote/core/api/api_client.dart';
import 'package:plotvote/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:plotvote/features/auth/data/repo/auth_repo_impl.dart';
import 'package:plotvote/features/auth/domain/repo/auth_repo.dart';
import 'package:plotvote/features/auth/presentation/bloc/user_bloc.dart';
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

  getIt.registerSingleton(AuthRemoteDatasource(dio: dio));
}

void registerRepo() {
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authRemoteDatasource: getIt()));
}

void registerBloc() {
  getIt.registerFactory(() => UserBloc(authRepo: getIt()));
}

UserBloc getUserBloc() => getIt<UserBloc>();
