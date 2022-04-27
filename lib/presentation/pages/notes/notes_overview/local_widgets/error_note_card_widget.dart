import 'package:flutter/material.dart';
import 'package:skefra_task_diary/domain/notes/entity/note.dart';

class ErrorNoteCard extends StatelessWidget {
  final Note note;
  const ErrorNoteCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.error,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invalid Note, Please Contact Support.',
              style: Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                    fontSize: 18,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Details For Nerds:',
              style: Theme.of(context).primaryTextTheme.bodyText2,
            ),
            Text(
              note.failureOption.fold(
                //none()
                () => '',
                // some()
                (failure) => failure.toString(),
              ),
              style: Theme.of(context).primaryTextTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
