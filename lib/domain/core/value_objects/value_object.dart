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
