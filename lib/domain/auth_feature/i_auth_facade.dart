


import 'package:dartz/dartz.dart';
import 'package:ddd_todo_app/domain/auth_feature/auth_failure.dart';
import 'package:ddd_todo_app/domain/auth_feature/value_objects.dart';

abstract class IAuthFacade{

  Future<Either<AuthFailure,Unit>> registerWithEmailAndPassword({
  required EmailAddress emailAddress,
  required Password password
});
  Future<Either<AuthFailure,Unit>> signInWithEmailAndPassword({
  required EmailAddress emailAddress,
  required Password password
});

  Future<Either<AuthFailure, Unit>> signInWithGoogle();





}