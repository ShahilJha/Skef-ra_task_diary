import 'package:skefra_task_diary/domain/core/value_failures/value_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:skefra_task_diary/domain/core/value_objects/value_object.dart';
import 'package:uuid/uuid.dart';

class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  const UniqueId._(this.value);

  ///create a UniqueId object with a unique id
  factory UniqueId() {
    return UniqueId._(
      right(const Uuid().v1()),
    );
  }

  ///create a UniqueId object from a given string
  ///with the assumption that the input value is correct
  ///and validated from the source from which it is obtained from
  factory UniqueId.fromUniqueString(String uniqueId) {
    return UniqueId._(
      right(uniqueId),
    );
  }
}
