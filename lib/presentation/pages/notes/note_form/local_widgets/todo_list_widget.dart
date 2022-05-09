import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';
import 'package:provider/provider.dart' as provider;
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
      child: provider.Consumer<FormTodos>(
        builder: (context, formTodos, child) {
          return ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onReorder: (int oldIndex, int newIndex) {
              if (newIndex > oldIndex) newIndex--;

              //assign item to temp variable
              final tempValue = context.read<FormTodos>().value[oldIndex];
              //convert to mutuable
              final mutableList = context.read<FormTodos>().value.asList();

              //change index from old to new
              mutableList
                ..removeAt(oldIndex)
                ..insert(newIndex, tempValue);

              //put new list to immutable and assign to <FormTodo>
              context.read<FormTodos>().value = mutableList.toImmutableList();

              //communicate change to bloc through event
              context.read<NoteFormBloc>().add(
                    NoteFormEvent.todosChanged(context.read<FormTodos>().value),
                  );
            },
            itemCount: formTodos.value.size,
            itemBuilder: (context, index) {
              return Container(
                key: ValueKey(context.read<FormTodos>().value[index].id),
                child: provider.ChangeNotifierProvider.value(
                  value: context.read<FormTodos>(),
                  child: TodoTile(
                    index: index,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
