import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:skefra_task_diary/domain/core/errors/unexpected_value_error.dart';

import '../value_failures/value_failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  ///Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    //id - identity - same as writing (right) => right
    return value.fold(
      (leftFailure) => throw UnexpectedValueError(leftFailure),
      id,
    );
  }

  /// returns wheather the object is valid or not
  bool isValid() => value.isRight();

  /*
    getter to get _ValueFailure<dynamic>_ for the purpose of getting 
    failures that do not confirm to any specific data type.
    This makes it easier to validate an _Entity_ that could have resulted 
    data type error when validating that entity as a whole.
    We don't care about the type of ValueFailure or the right Value of the
    ValueObject, we just consider if there is any ValueFailure or not 
    thourgh this getter variable.
  */
  ///Gives generic _ValueFailure<dynamic>_ of a _ValueObject_
  Either<ValueFailure<dynamic>, Unit> get failureOrUnit => value.fold(
        (l) => left(l),
        (r) => right(unit),
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ValueObject<$T>(value: $value)';
}
