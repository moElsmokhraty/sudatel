import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/spinkit.dart';
import '../../../../../../core/routing/app_routes.dart';
import 'package:sudatel/core/routing/navigation_extension.dart';
import '../../../../../../core/widgets/buttons/gradient_button.dart';
import '../../../../../auth/presentation/cubits/login_cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Welcome ${state.user?.email}')),
          );
          await context.pushNamedAndRemoveUntil(
            AppRoutes.home,
            predicate: (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SpinKitCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ],
          );
        } else {
          return GradientButton(
            onPressed: () async {
              await context.read<LoginCubit>().login();
            },
            text: 'Sign in',
          );
        }
      },
    );
  }
}
