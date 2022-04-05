import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skefra_task_diary/injection.dart';
import 'package:skefra_task_diary/presentation/pages/sign_in/local_widgets/sign_in_form.dart';
import 'package:skefra_task_diary/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) => getIt<SignInFormBloc>(),
        child: const SignInForm(),
      ),
    );
  }
}
