import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kt_dart/kt.dart';
import 'package:skefra_task_diary/application/notes/note_form/note_form_bloc.dart';
import 'package:skefra_task_diary/presentation/pages/notes/note_form/misc/form_todos.dart';
import 'package:skefra_task_diary/presentation/pages/notes/note_form/misc/toto_items_presentation_classes.dart';

class TodoTile extends HookWidget {
  final int index;
  const TodoTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formTodoProvider = context.read<FormTodos>();
    //returns an _TodoTIle_ with and empty _TodoItemPrimitive.empty()_
    final todo = formTodoProvider.value.getOrElse(
      index,
      (_) => TodoItemPrimitive.empty(),
    );
    return ListTile(
      leading: Checkbox(
        value: todo.done,
        onChanged: (value) {
          //mapping or replacing all value in the list, as the KtList us immutable
          formTodoProvider.value = formTodoProvider.value.map(
            (listTodo) =>
                listTodo == todo ? todo.copyWith(done: value!) : listTodo,
          );
          //passing the _TodoItemPrimitive_ to the _NoteFormBLoc_ through the _NoteFormEvent.todosChanged(value)_
          context.read<NoteFormBloc>().add(
                NoteFormEvent.todosChanged(formTodoProvider.value),
              );
        },
      ),
      title: Text(todo.name),
    );
  }
}
