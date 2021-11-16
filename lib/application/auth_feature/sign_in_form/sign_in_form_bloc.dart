
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

  }

}
