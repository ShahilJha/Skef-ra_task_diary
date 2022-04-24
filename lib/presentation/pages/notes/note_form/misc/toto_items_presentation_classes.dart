import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skefra_task_diary/domain/core/value_objects/unique_id.dart';

import '../../../../../domain/notes/entity/todo_item.dart';
import '../../../../../domain/notes/value_objects/todo_name.dart';

part 'toto_items_presentation_classes.freezed.dart';

@freezed
class TodoItemPrimitive with _$TodoItemPrimitive {
  const TodoItemPrimitive._();

  const factory TodoItemPrimitive({
    required UniqueId id,
    required String name,
    required bool done,
  }) = _TodoItemPrimitive;

  factory TodoItemPrimitive.empty() => TodoItemPrimitive(
        id: UniqueId(),
        name: '',
        done: false,
      );

  factory TodoItemPrimitive.fromDomain(TodoItem todoItem) => TodoItemPrimitive(
        id: todoItem.id,
        name: todoItem.name.getOrCrash(),
        done: todoItem.done,
      );

  TodoItem toDomain() => TodoItem(
        id: id,
        name: TodoName(name),
        done: done,
      );
}
