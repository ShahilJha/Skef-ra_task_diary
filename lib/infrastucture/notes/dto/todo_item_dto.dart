import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skefra_task_diary/domain/core/value_objects/unique_id.dart';
import 'package:skefra_task_diary/domain/notes/entity/todo_item.dart';
import 'package:skefra_task_diary/domain/notes/value_objects/todo_name.dart';

part 'todo_item_dto.freezed.dart';
part 'todo_item_dto.g.dart';

@freezed
class TodoItemDTO with _$TodoItemDTO {
  const TodoItemDTO._();

  const factory TodoItemDTO({
    required String id,
    required String name,
    required bool done,
  }) = _TodoItemDTO;

  factory TodoItemDTO.fromDomain(TodoItem todoItem) => TodoItemDTO(
        id: todoItem.id.getOrCrash(),
        name: todoItem.name.getOrCrash(),
        done: todoItem.done,
      );

  TodoItem toDomain() => TodoItem(
        id: UniqueId.fromUniqueString(id),
        name: TodoName(name),
        done: done,
      );

  factory TodoItemDTO.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDTOFromJson(json);
}
