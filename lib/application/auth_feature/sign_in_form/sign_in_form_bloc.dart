
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ddd_todo_app/domain/auth_feature/auth_failure.dart';
import 'package:ddd_todo_app/domain/auth_feature/i_auth_facade.dart';
import 'package:ddd_todo_app/domain/auth_feature/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';



class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  SignInFormBloc(SignInFormState initialState, this._authFacade) : super(initialState);

  final IAuthFacade _authFacade;

  @override
  SignInFormState get initialState => SignInFormState.initial();

/*  SignInFormBloc() : super(SignInFormState.initial()) {
    on<SignInFormEvent>((event, emit) {

    });
  }*/

  @override
  Stream<SignInFormState> mapEventToState( SignInFormEvent event)async*{
    yield* event.map(
        emailChanged: (e)async*{
          yield state.copyWith(
            emailAddress: EmailAddress(e.emailStr),
            authFailureOrSuccesOption: none(),
          );
        },
        passwordChanged: (e)async*{
          yield state.copyWith(
            password: Password(e.passwordStr),
            authFailureOrSuccesOption: none()
          );
        },
        registerWithEmailAndPasswordPressed: (e)async*{

          yield* _performActionOnAuthFacadeWithEmailAndPassword(_authFacade.registerWithEmailAndPassword );

        },
        signInWithEmailAndPasswordPressed: (e)async*{

          yield* _performActionOnAuthFacadeWithEmailAndPassword(_authFacade.registerWithEmailAndPassword);

        },

        signInWithGooglePressed: (e)async*{
          yield state.copyWith(
            isSubmitting: true,
            authFailureOrSuccesOption: none()
          );
          final failureOrSuccess = await _authFacade.signInWithGoogle();
          yield state.copyWith(
            isSubmitting: false,
            authFailureOrSuccesOption: some(failureOrSuccess),
          );

        },
        );

  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
      Future<Either<AuthFailure,Unit>> Function({
      required EmailAddress emailAddress,
      required Password password,
  }) forwardedCall,
      ) async*{
    late Either<AuthFailure, Unit> failureOrSuccess;

    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if(isEmailValid && isPasswordValid){
      yield state.copyWith(
          isSubmitting: true,
          authFailureOrSuccesOption: none()
      );
      failureOrSuccess = await forwardedCall(
          emailAddress: state.emailAddress, password: state.password);

    }
    yield state.copyWith(
      isSubmitting: false,
      showErrorMessage: true,
      authFailureOrSuccesOption: optionOf(failureOrSuccess),
    );
  }

}
