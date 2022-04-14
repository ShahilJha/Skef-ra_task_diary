import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes_value_failure.freezed.dart';

@freezed
class NotesValueFailure<T> with _$NotesValueFailure<T> {
  const factory NotesValueFailure.listTooLong({
    required T failedValue,
    required int max,
  }) = ListTooLong<T>;
}
