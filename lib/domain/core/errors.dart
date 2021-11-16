

import 'package:ddd_todo_app/domain/core/failures.dart';

class UnExpectedValueError extends Error{
  final ValueFailure valueFailure;

  UnExpectedValueError({ required this.valueFailure});

  @override
  String toString(){
    const explanation = 'Encountered a ValueFailure at an unrecoverable point. Terminating.';

    return Error.safeToString('$explanation Failure was: $valueFailure');
  }

}