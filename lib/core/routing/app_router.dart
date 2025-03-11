import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudatel/core/di/service_locator.dart';
import '../../features/auth/data/repos/auth_repo/auth_repo.dart';
import '../../features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import '../../features/home/data/repos/home_repo/home_repo.dart';
import '../../features/home/presentation/cubits/home_cubit/home_cubit.dart';
import '../../features/home/presentation/views/home_view/home_view.dart';
import '/core/routing/app_routes.dart';
import '../../features/auth/presentation/views/login_view/login_view.dart';
import '../../features/splash/presentation/views/splash_view/splash_view.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        return transitionPage(const SplashView());
      case AppRoutes.login:
        return transitionPage(BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(getIt.get<AuthRepo>()),
          child: const LoginView(),
        ));
      case AppRoutes.home:
        return transitionPage(BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(getIt.get<HomeRepo>())..didUserCheckInToday(),
          child: const HomeView(),
        ));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Text(
                  'No route defined for ${settings.name}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }

  static PageRouteBuilder transitionPage(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
