import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:skefra_task_diary/domain/core/value_objects/unique_id.dart';
import 'package:skefra_task_diary/domain/notes/entity/note.dart';
import 'package:skefra_task_diary/domain/notes/value_objects/note_body.dart';
import 'package:skefra_task_diary/domain/notes/value_objects/note_color.dart';
import 'package:skefra_task_diary/domain/notes/value_objects/todo_list.dart';
import 'package:skefra_task_diary/infrastucture/notes/dto/todo_item_dto.dart';

import '../server_timestamp_converter.dart';

part 'note_dto.freezed.dart';
part 'note_dto.g.dart';

/*
  Note DTO for firestore specific operations only
    --identifier : id
    {
      body: 'some.string',
      color: 1234567,
      todos: [...]
    }
  
  Here, the _id_ denotes the document in the _firestore_ rather than the id of
  the note itself like in a mysql database implementation

  Here, 
    required FieldValue serverTimeStamp,
  is a _Firestore_ specific value data type "Sentinel values" that can be used 
  when writing document fields with set() or update().
  
  Sentinel values means those value that are not pass from with-in out application.
  In this type of placerholder value arrives at the firestore to be a real time value 
  according to the server time.
    Place Holder Value ---> Real Value i.e. Time on Server
*/
@freezed
class NoteDTO with _$NoteDTO {
  const NoteDTO._();

  const factory NoteDTO({
    // ignore: invalid_annotation_target
    @JsonKey(ignore: true) String? id,
    required String body,
    required int color,
    required List<TodoItemDTO> todoList,
    @ServerTimestampConverter() required FieldValue serverTimeStamp,
  }) = _NoteDTO;

  factory NoteDTO.fromDomain(Note note) => NoteDTO(
        id: note.id.getOrCrash(),
        body: note.body.getOrCrash(),
        color: note.color.getOrCrash().value,
        todoList: note.todoList
            .getOrCrash()
            .map(
              (todoItem) => TodoItemDTO.fromDomain(todoItem),
            )
            .asList(),
        serverTimeStamp: FieldValue.serverTimestamp(),
      );

  Note toDomain() => Note(
        id: UniqueId.fromUniqueString(id!),
        body: NoteBody(body),
        color: NoteColor(Color(color)),
        todoList: TodoList(
          todoList
              .map(
                (todoItemDTO) => todoItemDTO.toDomain(),
              )
              .toImmutableList(),
        ),
      );

  factory NoteDTO.fromJson(Map<String, dynamic> json) =>
      _$NoteDTOFromJson(json);

  ///_DocumentSnapshot_ is a Firestore specific data type
  ///DocumentSnapshot doc;
  ///_doc.data()_ is of type Map<String, dynamic>;
  ///According to the _FlutterFire_ usage documentation
  factory NoteDTO.fromFirestore(DocumentSnapshot document) =>
      NoteDTO.fromJson(document.data()! as Map<String, dynamic>).copyWith(
        id: document.id,
      );
}
