import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

import '../../core/value_failures/value_failures.dart';
import '../../core/value_objects/value_object.dart';
import '../notes_value_validators.dart';

class TodoList<T> extends ValueObject<KtList<T>> {
  @override
  final Either<ValueFailure<KtList<T>>, KtList<T>> value;
  static const maxLength = 5;

  const TodoList._(this.value);

  factory TodoList(KtList<T> input) =>
      TodoList._(validateMaxListLength(input, maxLength));

  ///Returns the length of the object list and 0 if value failure or empty list
  int get length => value.getOrElse(() => emptyList()).size;

  ///Returns _ture_ if object list is full and _false_ if not
  bool get isFull => length == maxLength;
}
