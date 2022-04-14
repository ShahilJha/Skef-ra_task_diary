import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';
import 'package:skefra_task_diary/domain/notes/entity/note.dart';
import 'package:skefra_task_diary/domain/notes/note_failures.dart';

abstract class INoteRepository {
  Stream<Either<NoteFailure, KtList<Note>>> watchAll();
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted();
  Future<Either<NoteFailure, Unit>> create(Note note);
  Future<Either<NoteFailure, Unit>> update(Note note);
  Future<Either<NoteFailure, Unit>> delete(Note note);
}
