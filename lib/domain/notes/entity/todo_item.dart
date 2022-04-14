import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skefra_task_diary/domain/core/value_failures/value_failures.dart';
import 'package:skefra_task_diary/domain/core/value_objects/unique_id.dart';
import 'package:skefra_task_diary/domain/notes/notes_value_objects.dart';

part 'todo_item.freezed.dart';
/*
  if you are required to add a custom function/method to a _freezed class_
  you need to define a private constructor with the class
*/

@freezed
class TodoItem with _$TodoItem {
  const TodoItem._();

  const factory TodoItem({
    required UniqueId id,
    required TodoName name,
    required bool done,
  }) = _TodoItem;

  factory TodoItem.empty() => TodoItem(
        id: UniqueId(),
        name: TodoName(''),
        done: false,
      );

  /*
    Here, the _id_ is not considered because _UniqueId_ is always valid _i.e. right(..)_
    so not really needed to be considered in the below method.

    We can validate the entity as a whole for entities with few value_objects as: 
    ```
      Option<ValueFailure<dynamic>> get failureOption =>
      valueObject.value.fold((failure) => some(failure), (_) => none());
    ```
    when we are required to validate an _Entity_ that has many _ValueObjects_
    we van do it as following:
    ```
      Option<ValueFailure<dynamic>> get failureOption =>
        valueObject1.failureOrUnit.andThen(
          valueObject2.failureOrUnit).fold(
            (failure) => some(failure),
            (_) => none(),
        );
    ```

  */
  ///Gives validity or failure of the entity as a whole.
  Option<ValueFailure<dynamic>> get failureOption => name.failureOrUnit.fold(
        (failure) => some(failure),
        (_) => none(),
      );
}
