import 'package:dartz/dartz.dart';

import '../../core/value_failures/value_failures.dart';
import '../../core/value_objects/value_object.dart';
import '../notes_value_validators.dart';

class TodoName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;
  static const maxLength = 30;

  const TodoName._(this.value);

  factory TodoName(String input) => TodoName._(
        validateMaxStringLength(input, maxLength)
            .flatMap(validateStringNotEmpty)
            .flatMap(validateSigleLine),
      );
}
