import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/service_locator.dart';
import 'core/routing/app_routes.dart';
import 'core/utils/bloc_observer.dart';
import 'firebase_options.dart';
import 'core/routing/app_router.dart';
import 'core/styles/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    ScreenUtil.ensureScreenSize(),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarColor: AppColors.darkestRed,
    statusBarIconBrightness: Brightness.dark,
  ));
  setupServiceLocator();
  Bloc.observer = CustomBlocObserver();
  runApp(const Sudatel());
}

class Sudatel extends StatelessWidget {
  const Sudatel({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      child: MaterialApp(
        title: 'Sudatel',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: FirebaseAuth.instance.currentUser != null
            ? AppRoutes.home
            : AppRoutes.splash,
      ),
    );
  }
}
