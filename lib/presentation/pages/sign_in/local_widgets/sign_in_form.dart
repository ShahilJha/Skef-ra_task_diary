import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skefra_task_diary/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:skefra_task_diary/injection.dart';
import 'package:skefra_task_diary/presentation/ui_util/utilities.dart';
import 'package:skefra_task_diary/presentation/widgets/app_button.dart';
import 'package:skefra_task_diary/presentation/widgets/app_text_field.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<SignInFormBloc>();
    final TextEditingController _controller = TextEditingController();
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        //show error in snackbar
        state.authFailureOrSuccessOption.fold(
          () {
            //none()
          },
          //some()
          (either) => either.fold(
            //AuthFailure
            (leftFailure) {
              getIt<Utilities>().showSnackBar(
                text: leftFailure.map(
                  cancelledByUser: (_) => 'Cancelled',
                  serverError: (_) => 'Server Error',
                  emailALreadyInUse: (_) => 'Email Already in Use',
                  invalidEmailAndPasswordCombination: (_) =>
                      'Invalid Email and Password Combination',
                ),
              );
            },
            //Unit
            (_) {
              //Navigation
              context.navigateNamedTo('/home');
            },
          ),
        );

        //show in-process circular indicator
        state.isSubmitting == true ? getIt<Utilities>().showProcessing() : null;
      },
      builder: (context, state) {
        final mediaQuery = MediaQuery.of(context);
        final screenHeight = mediaQuery.size.height * 0.88;
        return SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              child: Center(
                child: Form(
                  autovalidateMode: state.showErrorMessages
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        autoFocus: true,
                        controller: _controller,
                        onSuffixIconPressed: () => _bloc
                            .add(const SignInFormEvent.clearEmailAddress()),
                        textFieldType: TextFieldType.email,
                        labelText: 'Email',
                        onChanged: (value) =>
                            _bloc.add(SignInFormEvent.emailChanged(value)),
                        validator: (_) => _bloc.state.emailAddress.value.fold(
                          (leftFailure) => leftFailure.authFailure.maybeMap(
                            invalidEmail: (_) => 'Invalid Email',
                            orElse: () => null,
                          ),
                          (r) => null,
                        ),
                      ),
                      AppTextField(
                        textFieldType: TextFieldType.password,
                        labelText: 'Password',
                        onSuffixIconPressed: () => _bloc.add(
                          SignInFormEvent.togglePasswordObscurity(
                            state.obscurePassword,
                          ),
                        ),
                        obscurePassword: state.obscurePassword,
                        onChanged: (value) =>
                            _bloc.add(SignInFormEvent.passwordChanged(value)),
                        validator: (_) => _bloc.state.password.value.fold(
                          (leftFailure) => leftFailure.authFailure.maybeMap(
                            shortPassword: (_) => 'Invalid Password',
                            orElse: () => null,
                          ),
                          (r) => null,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppButton(
                            name: 'Sign In',
                            onPressed: () => _bloc.add(
                              const SignInFormEvent
                                  .signInWithEmailAndPasswordPressed(),
                            ),
                          ),
                          AppButton(
                            name: 'Register',
                            onPressed: () => _bloc.add(
                              const SignInFormEvent
                                  .registerWithEmailAndPasswordPressed(),
                            ),
                          ),
                        ],
                      ),
                      AppButton(
                        name: 'Sign In With Google',
                        color: Colors.blue.shade400,
                        onPressed: () => _bloc.add(
                          const SignInFormEvent.signInWithGooglePressed(),
                        ),
                      ),
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
