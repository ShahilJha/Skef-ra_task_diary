import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';
import 'package:provider/provider.dart';
import 'package:skefra_task_diary/application/notes/note_form/note_form_bloc.dart';
import 'package:skefra_task_diary/domain/notes/value_objects/todo_list.dart'
    as widget;
import 'package:skefra_task_diary/injection.dart';
import 'package:skefra_task_diary/presentation/pages/notes/note_form/local_widgets/todo_tile_widget.dart';
import 'package:skefra_task_diary/presentation/pages/notes/note_form/misc/form_todos.dart';
import 'package:skefra_task_diary/presentation/ui_util/utilities.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<NoteFormBloc>();
    final _formTodoProvider = context.read<FormTodos>();
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.note.todoList.isFull != current.note.todoList.isFull,
      listener: (context, state) {
        if (state.note.todoList.isFull) {
          getIt<Utilities>().showSnackBar(
              text:
                  'Maximum Limit Reached: ${widget.TodoList.maxLength} Tasks');
        }
      },
      child: Consumer<FormTodos>(
        builder: (context, formTodos, child) {
          return ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onReorder: (int oldIndex, int newIndex) {
              if (newIndex > oldIndex) newIndex--;

              //assign item to temp variable
              final tempValue = _formTodoProvider.value[oldIndex];
              //convert to mutuable
              final mutableList = _formTodoProvider.value.asList();

              //change index from old to new
              mutableList
                ..removeAt(oldIndex)
                ..insert(newIndex, tempValue);

              //put new list to immutable and assign to <FormTodo>
              _formTodoProvider.value = mutableList.toImmutableList();

              //communicate change to bloc through event
              _bloc.add(
                NoteFormEvent.todosChanged(_formTodoProvider.value),
              );
            },
            itemCount: formTodos.value.size,
            itemBuilder: (context, index) {
              return TodoTile(
                key: ValueKey(_formTodoProvider.value[index].id),
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
