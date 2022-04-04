import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
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
    on<SignInFormEvent>((event, emit) {
      event.map(
        emailChanged: (e) async* {
          emit(
            state.copyWith(
              emailAddress: EmailAddress(e.emailStr),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        passwordChanged: (e) async* {
          emit(
            state.copyWith(
              password: Password(e.passwordStr),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        registerWithEmailAndPasswordPressed: (e) async* {
          _performActionOnAuthFacadeWithEmailAndPassword(
            _authFacade.registerWithEmailAndPassword,
          );
        },
        signInWithEmailAndPasswordPressed: (e) async* {
          _performActionOnAuthFacadeWithEmailAndPassword(
            _authFacade.signInWithEmailAndPassword,
          );
        },
        signInWithGooglePressed: (e) async* {
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
        },
      );
    });
  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
    Future<Either<AuthFailure, Unit>> Function({
      required EmailAddress emailAddress,
      required Password password,
    })
        forwardedCall,
  ) async* {
    Either<AuthFailure, Unit>? failureOrSuccess;

    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      failureOrSuccess = await forwardedCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }

    yield state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      //optionOf() -> will return none() or some() according to the data null status
      authFailureOrSuccessOption: optionOf(failureOrSuccess),
    );
  }
}
