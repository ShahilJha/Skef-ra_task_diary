import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:skefra_task_diary/domain/notes/i_note_repository.dart';
import 'package:skefra_task_diary/domain/notes/note_failures.dart';

import '../../../domain/notes/entity/note.dart';

part 'note_watcher_event.dart';
part 'note_watcher_state.dart';
part 'note_watcher_bloc.freezed.dart';

/*
  If we don't want to change between the completed list and the uncompleted list,
  and only had one event, for example: the "_WatchAllStarted" event only,
  then the following code will suffice to handle a _stream_ :
          (failureOrNotes) => failureOrNotes.fold(
                (failure) => emit(NoteWatcherState.loadFailure(failure)),
                (notes) => emit(NoteWatcherState.loadSuccess(notes)),
              ),
            );
  
  this is becasue the stream will keep on letting out data and states are going to 
  be emitted at all time, this makes it so that we can not use another stream to 
  output other data and subsequantly not allow us to emit new states for that event
*/

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  final INoteRepository _noteRepository;
  NoteWatcherBloc(this._noteRepository) : super(const _Initial()) {
    on<_WatchAllStarted>(
      (event, emit) {
        emit(const NoteWatcherState.loadInProgress());
        _noteRepository.watchAll().map(
              (failureOrNotes) => failureOrNotes.fold(
                (failure) => emit(NoteWatcherState.loadFailure(failure)),
                (notes) => emit(NoteWatcherState.loadSuccess(notes)),
              ),
            );
      },
    );

    on<_WatchUncompletedStarted>(
      (event, emit) {},
    );

    // on<>((event, emit) {},);
  }
}
