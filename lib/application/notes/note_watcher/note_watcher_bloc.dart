import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:skefra_task_diary/domain/notes/note_failures.dart';

import '../../../domain/notes/entity/note.dart';

part 'note_watcher_event.dart';
part 'note_watcher_state.dart';
part 'note_watcher_bloc.freezed.dart';

class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  NoteWatcherBloc() : super(const _Initial()) {
    on<NoteWatcherEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
