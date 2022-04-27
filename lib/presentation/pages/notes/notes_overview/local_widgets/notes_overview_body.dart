import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skefra_task_diary/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:skefra_task_diary/presentation/widgets/processing_indicator.dart';

class NotesOverviewBody extends StatelessWidget {
  const NotesOverviewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteWatcherBloc, NoteWatcherState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          loadInProgress: (_) => const ProcessingIndicator(neumorphic: true),
          loadSuccess: (state) {
            return ListView.builder(
              itemCount: state.notes.size,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return note.failureOption.isSome()
                    ? Container(
                        color: Colors.red,
                        height: 150,
                      )
                    : Container(
                        color: Colors.green,
                        height: 150,
                      );
              },
            );
          },
          loadFailure: (state) => Container(
            color: Colors.purpleAccent,
            height: 200,
          ),
        );
      },
    );
  }
}
