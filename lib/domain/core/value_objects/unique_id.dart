import 'package:skefra_task_diary/domain/core/value_failures/value_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:skefra_task_diary/domain/core/value_objects/value_object.dart';
import 'package:uuid/uuid.dart';

class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  const UniqueId._(this.value);

  factory UniqueId() {
    return UniqueId._(
      right(const Uuid().v1()),
    );
  }

  factory UniqueId.fromUniqueString(String uniqueId) {
    return UniqueId._(
      right(uniqueId),
    );
  }
}
