import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:skefra_task_diary/domain/auth/i_auth_facade.dart';

import '../../../domain/auth/auth_failure.dart';
import '../../../domain/auth/auth_value_objects.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    on<EmailChanged>(((event, emit) async {
      emit(
        state.copyWith(
          emailAddress: EmailAddress(event.emailStr),
          authFailureOrSuccessOption: none(),
        ),
      );
    }));

    on<PasswordChanged>(((event, emit) async {
      emit(
        state.copyWith(
          password: Password(event.passwordStr),
          authFailureOrSuccessOption: none(),
        ),
      );
    }));

    on<TogglePasswordObscurity>(((event, emit) async {
      emit(state.copyWith(
        obscurePassword: !event.obscurePassword,
        authFailureOrSuccessOption: none(),
      ));
    }));

    on<ClearEmailAddress>(((event, emit) async {
      emit(state.copyWith(
        authFailureOrSuccessOption: none(),
        emailAddress: EmailAddress(''),
      ));
    }));

    on<RegisterWithEmailAndPasswordPressed>(((event, emit) async {
      // ignore: todo
      //TODO: make implementation DRY
      // _performActionOnAuthFacadeWithEmailAndPassword(
      //   _authFacade.registerWithEmailAndPassword,
      //   emit,
      // );

      Either<AuthFailure, Unit>? failureOrSuccess;

      final isEmailValid = state.emailAddress.isValid();
      final isPasswordValid = state.password.isValid();

      if (isEmailValid && isPasswordValid) {
        emit(state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ));

        failureOrSuccess = await _authFacade.registerWithEmailAndPassword(
          emailAddress: state.emailAddress,
          password: state.password,
        );
      }

      emit(state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        //optionOf() -> will return none() or some() according to the data null status
        authFailureOrSuccessOption: optionOf(failureOrSuccess),
      ));
    }));

    on<SignInWithEmailAndPasswordPressed>(((event, emit) async {
      // ignore: todo
      //TODO: make implementation DRY
      // _performActionOnAuthFacadeWithEmailAndPassword(
      //   _authFacade.signInWithEmailAndPassword,
      //   emit,
      // );

      Either<AuthFailure, Unit>? failureOrSuccess;

      final isEmailValid = state.emailAddress.isValid();
      final isPasswordValid = state.password.isValid();

      if (isEmailValid && isPasswordValid) {
        emit(state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ));

        failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
          emailAddress: state.emailAddress,
          password: state.password,
        );
      }

      emit(state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        //optionOf() -> will return none() or some() according to the data null status
        authFailureOrSuccessOption: optionOf(failureOrSuccess),
      ));
    }));

    on<SignInWithGooglePressed>((event, emit) async {
      emit(
        state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ),
      );
      final failureOrSucess = await _authFacade.signInWithGoogle();
      emit(
        state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSucess),
        ),
      );
    });
  }

  // Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
  //   Future<Either<AuthFailure, Unit>> Function({
  //     required EmailAddress emailAddress,
  //     required Password password,
  //   })
  //       forwardedCall,
  //   Emitter<SignInFormState> emit,
  // ) async* {
  //   Either<AuthFailure, Unit>? failureOrSuccess;
  //   debugPrint('call SignInWithEmailAndPasswordPressed');

  //   final isEmailValid = state.emailAddress.isValid();
  //   final isPasswordValid = state.password.isValid();

  //   if (isEmailValid && isPasswordValid) {
  //     emit(state.copyWith(
  //       isSubmitting: true,
  //       authFailureOrSuccessOption: none(),
  //     ));

  //     failureOrSuccess = await forwardedCall(
  //       emailAddress: state.emailAddress,
  //       password: state.password,
  //     );
  //   }

  //   emit(state.copyWith(
  //     isSubmitting: false,
  //     showErrorMessages: true,
  //     //optionOf() -> will return none() or some() according to the data null status
  //     authFailureOrSuccessOption: optionOf(failureOrSuccess),
  //   ));
  // }
}
