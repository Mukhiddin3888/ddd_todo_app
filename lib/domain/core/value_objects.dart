

import 'package:dartz/dartz.dart';
import 'package:ddd_todo_app/domain/core/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


//object equality ( obj1 == obj2 ? )
@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

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