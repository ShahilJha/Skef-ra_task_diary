import 'package:dartz/dartz.dart';
import '../core/value_failures/value_failures.dart';
import '../core/value_objects/value_object.dart';
import '../core/value_validators/auth_value_validators.dart';

class EmailAddress extends ValueObject<String> {
  // ignore: annotate_overrides
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) =>
      EmailAddress._(validateEmailAddress(input));

  const EmailAddress._(this.value);
}

class Password extends ValueObject<String> {
  // ignore: annotate_overrides
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) => Password._(validatePassword(input));

  const Password._(this.value);
}
