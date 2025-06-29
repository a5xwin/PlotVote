import 'package:firebase_core/firebase_core.dart';
import 'package:plotvote/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotvote/core/di/get_it.dart';
import 'package:plotvote/core/router/app_router.dart';
import 'package:plotvote/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  setup();
  runApp(BlocProvider(
    create: (context) => getUserBloc(),
    child: MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
    ), // MaterialApp.router
  )); // BlocProvider
}
