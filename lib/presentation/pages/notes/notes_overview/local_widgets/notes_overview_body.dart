import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skefra_task_diary/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:skefra_task_diary/presentation/pages/notes/notes_overview/local_widgets/critical_failure_display_widget.dart';
import 'package:skefra_task_diary/presentation/pages/notes/notes_overview/local_widgets/error_note_card_widget.dart';
import 'package:skefra_task_diary/presentation/pages/notes/notes_overview/local_widgets/note_card_widget.dart';
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
                    ? ErrorNoteCard(note: note)
                    : NoteCard(note: note);
              },
            );
          },
          loadFailure: (state) =>
              CriticalFailureDisplay(failure: state.noteFailure),
        );
      },
    );
  }
}
