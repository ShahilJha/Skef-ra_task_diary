import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:skefra_task_diary/domain/core/value_failures/value_failures.dart';
import 'package:skefra_task_diary/domain/core/value_objects/unique_id.dart';
import 'package:skefra_task_diary/domain/notes/entity/todo_item.dart';
import 'package:skefra_task_diary/domain/notes/notes_value_objects.dart';
part 'note.freezed.dart';

@freezed
class Note with _$Note {
  const Note._();

  const factory Note({
    required UniqueId id,
    required NoteBody body,
    required NoteColor color,
    required TodoList<TodoItem> todoList,
  }) = _Note;

  factory Note.empty() => Note(
        id: UniqueId(),
        body: NoteBody(''),
        color: NoteColor(NoteColor.predefinedColors.first),
        todoList: TodoList(emptyList()),
      );

  /*
    Similar to the _TodoItem_ from _todo\_item.dart_ the _fold()_ process is the same.
    But chain different value_objects we can use the _firstValueObject.andThen(nextValueObject)_ to concate 
    the instants that need to be required to process.
    __firstValueObject.andThen(nextValueObject)_ is similar to _flatMap()_ as they will not process to the next instance
    if _Either<>_ value is a _Failure_ on the first instance
  */
  ///Gives validity or failure of the entity as a whole.
  Option<ValueFailure<dynamic>> get failureOption => body.failureOrUnit
      .andThen(todoList.failureOrUnit)
      .andThen(
        /*
          we can call _todoList.getOrCrash()_ here without fear of crashing because
          we wouldn't get to this point if there was any type of failure, as they
          have already been validated in the above _body.failureOrUnit.andThen(todoList.failureOrUnit)_

          ```
            todoList
            .getOrCrash()
            //Getting the failureOption from the _TodoItem ENTITY_ - NOT a _failureOrUnit_ from a VALUE OBJECT
            //mapping each of the _TodoItem_ Entity and getting there failureOption as they are already validated, 
            //instead of _failureOrUnit_ 
            .map((todoItem) => todoItem.failureOption)
            //filter those that have _some()_ value atleast and ignore _none()_
            //as _failureOption_ has failure in _some()_
            .filter((o) => o.isSome())
            //if we can't get the 0th element, the list is empty. In such a case, it's valid.
            .getOrElse(0, (_) => none())
            .fold(
              //none()
              //if there is _none()_ then no failure is present, so returning _right(unit)_
              () => right(unit),
              //some()
              //if there is _some()_ then it gives a _failure_ as _failureOption_ only failue in _some()_
              (failure) => left(failure),
            ),
          ```
        */
        todoList
            .getOrCrash()
            .map((todoItem) => todoItem.failureOption)
            .filter((o) => o.isSome())
            .getOrElse(0, (_) => none())
            .fold(
              () => right(unit),
              (failure) => left(failure),
            ),
      )
      .fold(
        (failure) => some(failure),
        (_) => none(),
      );
}
