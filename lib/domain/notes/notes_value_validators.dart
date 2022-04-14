import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';
import 'package:skefra_task_diary/domain/core/value_failures/core_value_failures.dart';
import 'package:skefra_task_diary/domain/notes/notes_value_failure.dart';

import '../core/value_failures/value_failures.dart';

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(ValueFailure.core(CoreValueFaliue.exceedingLength(
      failedValue: input,
      max: maxLength,
    )));
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.core(CoreValueFaliue.empty(failedValue: input)));
  }
}

Either<ValueFailure<String>, String> validateSigleLine(String input) {
  if (!input.contains('\n')) {
    return right(input);
  } else {
    return left(
        ValueFailure.core(CoreValueFaliue.multiLine(failedValue: input)));
  }
}

Either<ValueFailure<KtList<T>>, KtList<T>> validateMaxListLength<T>(
  KtList<T> input,
  int maxLength,
) {
  if (input.size <= maxLength) {
    return right(input);
  } else {
    return left(ValueFailure.notes(NotesValueFailure.listTooLong(
      failedValue: input,
      max: maxLength,
    )));
  }
}
