import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:skefra_task_diary/application/notes/note_form/note_form_bloc.dart';
import 'package:skefra_task_diary/presentation/pages/notes/note_form/misc/form_todos.dart';
import 'package:skefra_task_diary/presentation/pages/notes/note_form/misc/toto_items_presentation_classes.dart';

class AddTodoTile extends StatelessWidget {
  const AddTodoTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formTodosProvider = context.read<FormTodos>();
    return BlocConsumer<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        formTodosProvider.value = state.note.todoList.value.fold(
          //failure => emptyList
          (failure) => listOf<TodoItemPrimitive>(),
          //value
          (todoItemList) => todoItemList.map(
            (_) => TodoItemPrimitive.fromDomain(_),
          ),
        );
      },
      buildWhen: (previous, current) =>
          previous.note.todoList.isFull != current.note.todoList.isFull,
      builder: (context, state) {
        return ListTile(
          //enable = false; when full
          enabled: !state.note.todoList.isFull,
          title: const Text('Add a todo'),
          leading: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.add),
          ),
          onTap: () {
            formTodosProvider.value =
                formTodosProvider.value.plusElement(TodoItemPrimitive.empty());
            context.read<NoteFormBloc>().add(
                  NoteFormEvent.todosChanged(context.read<FormTodos>().value),
                );
          },
        );
      },
    );
  }
}
