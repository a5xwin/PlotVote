import 'package:plotvote/core/theme/app_colors.dart';
import 'package:plotvote/core/ui/widgets/default_button.dart';
import 'package:plotvote/features/auth/presentation/bloc/user_bloc.dart';
import 'package:plotvote/features/auth/presentation/bloc/user_event.dart';
import 'package:plotvote/features/auth/presentation/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static const String route = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'plotvote',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge?.copyWith(
                      fontFamily: 'Parabole',
                      fontSize: 38
                      ),
                  ),
                  const Spacer(),
                  SvgPicture.asset('assets/images/login_image.svg'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Collaborative storytelling... until someone gets cancelled. Plot twists? Nah, more like plot betrayals! 😈',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontFamily: 'Montreal',
                        fontSize: 15
                        ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  DefaultButton(
                    text: 'Login with Google',
                    textColor: AppColors.textColor,
                    backgroundColor: AppColors.secondary,
                    onPressed: () {
                      context.read<UserBloc>().add(LoginWithGoogleEvent());
                    },
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state.status == UserStatus.error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage ?? '')));
            }
          },
        ),
      ),
    );
  }
}
