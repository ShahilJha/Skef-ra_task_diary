import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';
import 'package:skefra_task_diary/application/notes/note_actor/note_actor_bloc.dart';
import 'package:skefra_task_diary/domain/notes/entity/note.dart';
import 'package:skefra_task_diary/domain/notes/entity/todo_item.dart';
import 'package:skefra_task_diary/global_constants.dart';
import 'package:skefra_task_diary/presentation/routes/router.gr.dart';
import 'package:skefra_task_diary/presentation/widgets/app_button.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  const NoteCard({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 6,
      ),
      color: note.color.getOrCrash(),
      child: InkWell(
        onTap: () => context.router.navigate(NoteFormRoute(editedNote: note)),
        onLongPress: () {
          final noteActorBloc = context.read<NoteActorBloc>();
          _showDeletionDialgo(context, noteActorBloc);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.body.getOrCrash(),
                style: const TextStyle(fontSize: 18),
              ),
              if (note.todoList.length > 0) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: [
                    ...note.todoList
                        .getOrCrash()
                        .map(
                          (todo) => TodoDisplay(todo: todo),
                        )
                        .iter,
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  void _showDeletionDialgo(BuildContext context, NoteActorBloc noteActorBloc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selected Note: '),
          content: Text(
            note.body.getOrCrash(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            const Spacer(),
            AppButton(
              name: 'Delete',
              onPressed: () {
                noteActorBloc.add(NoteActorEvent.deleted(note));
                context.router.pop();
              },
            ),
            const Spacer(),
            AppButton(
              name: 'Cancel',
              onPressed: () => context.router.pop(),
              color: kScaffoldBackgroundColor,
              textColor: Theme.of(context).colorScheme.primary,
              borderColor: Theme.of(context).colorScheme.primary,
            ),
            const Spacer(),
          ],
        );
      },
    );
  }
}

class TodoDisplay extends StatelessWidget {
  final TodoItem todo;
  const TodoDisplay({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        todo.done
            ? Icon(
                Icons.check_box,
                color: Theme.of(context).colorScheme.secondary,
              )
            : Icon(
                Icons.check_box_outline_blank,
                color: Theme.of(context).colorScheme.secondary,
              ),
        Text(todo.name.getOrCrash()),
      ],
    );
  }
}
