import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skefra_task_diary/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:skefra_task_diary/presentation/widgets/app_text_field.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {},
      builder: (context, state) {
        final mediaQuery = MediaQuery.of(context);
        final screenHeight = mediaQuery.size.height * 0.88;
        return SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              child: Center(
                child: Form(
                  child: ListView(
                    children: [
                      AppTextField(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
