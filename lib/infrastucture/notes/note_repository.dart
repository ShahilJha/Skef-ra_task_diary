import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:skefra_task_diary/domain/notes/entity/note.dart';
import 'package:dartz/dartz.dart';
import 'package:skefra_task_diary/domain/notes/i_note_repository.dart';
import 'package:skefra_task_diary/domain/notes/note_failures.dart';
import 'package:skefra_task_diary/infrastucture/core/firestore_helpers.dart';
import 'package:rxdart/rxdart.dart';
import 'dto/note_dto.dart';

/*
  We can add another layer of abstraction to this file when dealing with
  problems where you use other services like a local database and REST-API,
  where you have to manually persist data unlike in _FireStore Services_ where 
  they are mostly automated.

  We can another layer abstration and use an interface here, such as:
    - final NoteFirestoreService _noteFirestoreService --> For Cloud FireStore itself here
    - final NoteRemoteService _noteRemoteService --> For REST-API
    - final NoteLocalService _noteLocalService --> For Local Databases like Moor, Sqlite, Hive, etc.
  
  These are the layer where you implement the nitty Gritty stuff such as caching.
*/

/*
  THe structure of the fireStore will be as such :
    User/{UserID}/notes/{noteID}

    User
      |__{UserId}
            |__notes
                  |__{noteId}
*/

@LazySingleton(as: INoteRepository)
class NoteRepository implements INoteRepository {
  final FirebaseFirestore _firestore;

  NoteRepository(this._firestore);

  @override
  Future<Either<NoteFailure, Unit>> create(Note note) async {
    try {
      final userDoc = await _firestore.userDocument();
      final noteDto = NoteDTO.fromDomain(note);

      await userDoc.noteCollection.doc(noteDto.id).set(noteDto.toJson());
      return right(unit);
    } on FirebaseException catch (exception) {
      if (exception.message!.contains('PERMISSION_DENIED')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        // log.error(e.toString())
        return left(const NoteFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<NoteFailure, Unit>> delete(Note note) async {
    try {
      final userDoc = await _firestore.userDocument();
      final noteId = note.id.getOrCrash();

      await userDoc.noteCollection.doc(noteId).delete();
      return right(unit);
    } on FirebaseException catch (exception) {
      if (exception.message!.contains('PERMISSION_DENIED')) {
        return left(const NoteFailure.insufficientPermission());
      } else if (exception.message!.contains('NOT_FOUND')) {
        return left(const NoteFailure.unableToDelete());
      } else {
        // log.error(e.toString())
        return left(const NoteFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<NoteFailure, Unit>> update(Note note) async {
    try {
      final userDoc = await _firestore.userDocument();
      final noteDto = NoteDTO.fromDomain(note);

      await userDoc.noteCollection.doc(noteDto.id).update(noteDto.toJson());
      return right(unit);
    } on FirebaseException catch (exception) {
      if (exception.message!.contains('PERMISSION_DENIED')) {
        return left(const NoteFailure.insufficientPermission());
      } else if (exception.message!.contains('NOT_FOUND')) {
        return left(const NoteFailure.unableToUpdate());
      } else {
        // log.error(e.toString())
        return left(const NoteFailure.unexpected());
      }
    }
  }

  @override
  Stream<Either<NoteFailure, KtList<Note>>> watchAll() async* {
    final userDoc = await _firestore.userDocument();
    yield* userDoc.noteCollection
        .orderBy(
          'serverTimeStamp',
          descending: true,
        )
        .snapshots()
        .map((snapshot) => right<NoteFailure, KtList<Note>>(
              snapshot.docs
                  .map((doc) => NoteDTO.fromFirestore(doc).toDomain())
                  .toImmutableList(),
            ))
        .onErrorReturnWith((exception, stackTrace) {
      if (exception is FirebaseException &&
          exception.message!.contains('PERMISSION_DENIED')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        // log.error(e.toString())
        return left(const NoteFailure.unexpected());
      }
    });
  }

  @override
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted() async* {
    final userDoc = await _firestore.userDocument();
    yield* userDoc.noteCollection
        .orderBy(
          'serverTimeStamp',
          descending: true,
        )
        .snapshots()
        //convertting the raw data to domain specific data type _Note_
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => NoteDTO.fromFirestore(doc).toDomain()),
        )
        //filtering those _Note_ that have at least one tast not completed/done
        .map(
          (notes) => right<NoteFailure, KtList<Note>>(
            notes
                .where((note) => note.todoList
                    .getOrCrash()
                    .any((todoItem) => !todoItem.done))
                .toImmutableList(),
          ),
        )
        .onErrorReturnWith((exception, stackTrace) {
      if (exception is FirebaseException &&
          exception.message!.contains('PERMISSION_DENIED')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        // log.error(e.toString())
        return left(const NoteFailure.unexpected());
      }
    });
  }
}
