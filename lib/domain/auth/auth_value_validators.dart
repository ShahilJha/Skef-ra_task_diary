import 'package:dartz/dartz.dart';
import 'package:skefra_task_diary/domain/auth/auth_value_failures.dart';
import '../core/value_failures/value_failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  // ignore: todo
  //TODO: change regex pattern to a more secured one
  const emailRegex =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.auth(InvalidEmail(failedValue: input)));
    // return left(ValueFailure.invalidEmail(failedValue: input));

  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length > 6) {
    return right(input);
  } else {
    return left(ValueFailure.auth(ShortPassword(failedValue: input)));
    // return left(ValueFailure.shortPassword(failedValue: input));
  }
}
