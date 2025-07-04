import 'package:plotvote/features/auth/domain/repo/auth_repo.dart';
import 'package:plotvote/features/auth/domain/repo/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepo authRepo;
  final UserRepo userRepo;

  UserBloc({required this.authRepo, required this.userRepo})
      : super(UserState.initial()) {
    on<LoginWithGoogleEvent>(onLoginWithGoogleEvent);
    on<GetUserEvent>(onGetUserEvent);
    on<LogoutEvent>(onLogoutEvent);
  }

  Future onLoginWithGoogleEvent(
      LoginWithGoogleEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var data = await authRepo.loginWithGoogle();
    if (data.isRight()) {
      emit(state.copyWith(status: UserStatus.success, userModel: data.right));
    } else {
      emit(state.copyWith(
          status: UserStatus.error, errorMessage: data.left.message));
    }
  }

  Future onGetUserEvent(GetUserEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var data = await userRepo.getUser();
    if (data.isRight()) {
      emit(state.copyWith(status: UserStatus.success, userModel: data.right));
    } else {
      emit(state.copyWith(
          status: UserStatus.error, errorMessage: data.left.message));
    }
  }

  Future onLogoutEvent(LogoutEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var result = await authRepo.logout();
    if (result.isRight()) {
      emit(state.copyWith(status: UserStatus.logout));
    } else {
      emit(state.copyWith(
          status: UserStatus.error, errorMessage: result.left.message));
    }
  }
}