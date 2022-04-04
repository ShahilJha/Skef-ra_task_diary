import 'package:skefra_task_diary/domain/core/value_failures/value_failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation = 'Encountered a ValueFailure at an unrecoverable point.';
    return Error.safeToString(
      '$explanation TERMINATING. Failure value: $valueFailure',
    );
  }
}
