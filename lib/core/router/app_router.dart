import 'package:go_router/go_router.dart';
import 'package:plotvote/features/auth/presentation/pages/auth_page.dart';

class AppRouter {
  static var router = GoRouter(initialLocation: AuthPage.route, routes: [
    // GoRoute(
    //     path: SplashPage.route,
    //     builder: (context, state) {
    //       return const SplashPage();
    //     }),
     GoRoute(
        path: AuthPage.route,
        builder: (context, state) {
          return AuthPage();
         }),
    // GoRoute(
    //     path: HomePage.route,
    //     builder: (context, state) {
    //       return const HomePage();
    //     },
    //     routes: [
    //       GoRoute(
    //           path: 'game/:id',
    //           builder: (context, state) {
    //             return GamePage(gameCode: state.pathParameters['id'] ?? '');
    //           })
    //     ]),
    // GoRoute(
    //     path: CreateGamePage.route,
    //     builder: (context, state) {
    //       return const CreateGamePage();
    //     })
  ]);
}