import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes_value_failure.freezed.dart';

@freezed
class NotesValueFailure<T> with _$NotesValueFailure<T> {
  const factory NotesValueFailure.exceedingLength({
    required T failedValue,
    required T max,
  }) = ExceedingLength<T>;
  const factory NotesValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;
  const factory NotesValueFailure.multiLine({
    required T failedValue,
  }) = MultiLine<T>;
  const factory NotesValueFailure.listTooLong({
    required T failedValue,
    required T max,
  }) = ListTooLong<T>;
}
