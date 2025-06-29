import 'package:plotvote/features/auth/domain/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepo authRepo;

  UserBloc({required this.authRepo}) : super(UserState.initial()) {
    on<LoginWithGoogleEvent>(onLoginWithGoogleEvent);
  }

  Future onLoginWithGoogleEvent(LoginWithGoogleEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var data = await authRepo.loginWithGoogle();
    if (data.isRight()) {
      emit(state.copyWith(status: UserStatus.success, userModel: data.right));
    } else {
      emit(state.copyWith(status: UserStatus.error, errorMessage: data.left.message));
    }
  }
}
