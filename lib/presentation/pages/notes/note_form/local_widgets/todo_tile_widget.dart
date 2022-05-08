import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kt_dart/kt.dart';
import 'package:skefra_task_diary/application/notes/note_form/note_form_bloc.dart';
import 'package:skefra_task_diary/domain/notes/value_objects/todo_name.dart';
import 'package:skefra_task_diary/presentation/pages/notes/note_form/misc/form_todos.dart';
import 'package:skefra_task_diary/presentation/pages/notes/note_form/misc/toto_items_presentation_classes.dart';
import 'package:skefra_task_diary/presentation/widgets/app_text_field.dart';

class TodoTile extends HookWidget {
  final int index;
  const TodoTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<NoteFormBloc>();
    final formTodoProvider = context.read<FormTodos>();
    //returns an _TodoTIle_ with an empty _TodoItemPrimitive.empty()_
    //in case of ArrayOutOfBound with the passed _index_
    final todo = formTodoProvider.value.getOrElse(
      index,
      (_) => TodoItemPrimitive.empty(),
    );
    //_TextEditingController_ to input text if todo already exists
    final textEditingController = useTextEditingController(text: todo.name);
    return Slidable(
      // key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).scaffoldBackgroundColor,
            icon: Icons.delete,
            label: 'Delete',
            onPressed: (context) {
              //removing the todo when deleting
              //_minusELement(value)_ removes the passed element
              //and returns the new list instead of directly removing the
              //item from the memory, as the list has not change, but only
              //giving a totally new list and we are replacing the new list
              //in the physical memory
              formTodoProvider.value =
                  formTodoProvider.value.minusElement(todo);
              //passing the _TodoItemPrimitive_ to the _NoteFormBLoc_ through the _NoteFormEvent.todosChanged(value)_
              _bloc.add(
                NoteFormEvent.todosChanged(formTodoProvider.value),
              );
            },
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Checkbox(
            value: todo.done,
            onChanged: (value) {
              //mapping or replacing all value in the list, as the KtList us immutable
              formTodoProvider.value = formTodoProvider.value.map(
                (listTodo) =>
                    listTodo == todo ? todo.copyWith(done: value!) : listTodo,
              );
              //passing the _TodoItemPrimitive_ to the _NoteFormBLoc_ through the _NoteFormEvent.todosChanged(value)_
              _bloc.add(
                NoteFormEvent.todosChanged(formTodoProvider.value),
              );
            },
          ),
          title: AppTextField(
            controller: textEditingController,
            textFieldType: TextFieldType.plain,
            hintText: 'Todo',
            textAlign: TextAlign.start,
            maxLength: TodoName.maxLength,
            counterText: '',
            onChanged: (value) {
              //mapping or replacing all value in the list, as the KtList us immutable
              formTodoProvider.value = formTodoProvider.value.map(
                (listTodo) =>
                    listTodo == todo ? todo.copyWith(name: value) : listTodo,
              );
              //passing the _TodoItemPrimitive_ to the _NoteFormBLoc_ through the _NoteFormEvent.todosChanged(value)_
              _bloc.add(
                NoteFormEvent.todosChanged(formTodoProvider.value),
              );
            },
            validator: (_) => _bloc.state.note.todoList.value.fold(
              //left ValueFailure of the whole list, not the individual list item
              (leftFailure) => null,
              //rightValue giving the _TodoListItem_ with the specified _[index]_
              (todoList) => todoList[index].name.value.fold(
                    //leftValueFailure of the _TodoItem[index]_
                    (leftValueFailure) => leftValueFailure.maybeMap(
                      core: (valueFailure) => valueFailure.coreFailure.maybeMap(
                        exceedingLength: (failure) =>
                            'Exceeding Length, Max: ${failure.max}',
                        empty: (_) => 'Empty Body',
                        multiLine: (_) => 'Todos can\'t be multi-lined',
                        orElse: () => null,
                      ),
                      orElse: () => null,
                    ),
                    //rightValue :: correct value, so need to do anything
                    (_) => null,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
