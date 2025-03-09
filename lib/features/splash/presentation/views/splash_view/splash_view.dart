import 'package:flutter/material.dart';
import 'package:sudatel/core/routing/navigation_extension.dart';
import '../../../../../core/routing/app_routes.dart';
import 'widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToMainView();
  }

  Future<void> _navigateToMainView() async {
    await Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.pushReplacementNamed(AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SplashViewBody(),
      ),
    );
  }
}
