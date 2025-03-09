import 'package:flutter/material.dart';
import 'widgets/login_view_body.dart';
import '../../../../../core/widgets/buttons/gradient_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: LoginViewBody(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GradientButton(
        onPressed: () {},
        text: 'Sign in',
      ),
    );
  }
}
