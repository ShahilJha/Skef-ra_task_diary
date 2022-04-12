import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (_) {
            context.navigateNamedTo('/home');
          },
          unauthenticated: (_) {
            context.navigateNamedTo('/login');
          },
        );
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/logo/logo.png',
            height: 250.0,
            width: 250.0,
          ),
        ),
      ),
    );
  }
}
