import 'package:freezed_annotation/freezed_annotation.dart';
part 'note_failures.freezed.dart';

@freezed
class NoteFailure with _$NoteFailure {
  const factory NoteFailure.unexpected() = _Unexpected;
  const factory NoteFailure.insufficientPermission() = _InsufficientPermission;
  const factory NoteFailure.unableToDelete() = _UnableToDelete;
  const factory NoteFailure.unableToUpdate() = _UnableToUpdate;
}
