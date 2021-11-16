

import 'package:dartz/dartz.dart';
import 'package:ddd_todo_app/domain/core/errors.dart';
import 'package:ddd_todo_app/domain/core/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


//object equality ( obj1 == obj2 ? )
@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  bool isValid()=> value.isRight();

  /// Throws [UnExpectedValueError] containing the [ValueFailure]
  T getOrCrash(){
    // id ==  (r) => r  id = identity
    return value.fold((f) => throw UnExpectedValueError(valueFailure: f),id );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}