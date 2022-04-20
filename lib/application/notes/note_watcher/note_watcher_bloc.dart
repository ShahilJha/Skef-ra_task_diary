import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
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
  ##FOR SINGLE STREAM 
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

/*
  ##FOR WHEN THERE ARE TWO OR MORE STREAMS

  Pass the listiened data from the stream to the event _"_NotesReceived"_ and then let
  the _"_NotesReceived"_ event bloc execute the operation of emitting the states.

  Since we can cancel the _listein_ of _StreamSubscription_ from one stream and start to
  _listein_ another, this allows us to switch from two or more different stream of data.

  To do this switching we need store the _StreamSubscription_ to a field,
  in this case here, we store it into the field:
    ```
      StreamSubscription<Either<NoteFailure, KtList<Note>>>? _notesStreamSubcription;
    ```
  
*/

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  final INoteRepository _noteRepository;

  StreamSubscription<Either<NoteFailure, KtList<Note>>>?
      _notesStreamSubcription;

  NoteWatcherBloc(this._noteRepository) : super(const _Initial()) {
    on<_WatchAllStarted>(
      (event, emit) async {
        emit(const NoteWatcherState.loadInProgress());
        //cancel any stream subscription
        await _notesStreamSubcription?.cancel();
        _notesStreamSubcription = _noteRepository.watchAll().listen(
              (failureOrNotes) => add(
                NoteWatcherEvent.notesReceived(failureOrNotes),
              ),
            );
      },
    );

    on<_WatchUncompletedStarted>(
      (event, emit) async {
        emit(const NoteWatcherState.loadInProgress());
        //cancel any stream subscription
        await _notesStreamSubcription?.cancel();
        // if (_notesStreamSubcription != null) {
        //   await _notesStreamSubcription!
        //       .cancel(); //cancel any stream subscription
        // }
        _notesStreamSubcription = _noteRepository.watchUncompleted().listen(
              (failureOrNotes) => add(
                NoteWatcherEvent.notesReceived(failureOrNotes),
              ),
            );
      },
    );

    on<_NotesReceived>(
      (event, emit) {
        event.failureOrNotes.fold(
          (failure) => emit(NoteWatcherState.loadFailure(failure)),
          (notes) => emit(NoteWatcherState.loadSuccess(notes)),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    /*
      Cancel/Close any stream subscription when exiting the bloc to prevent 
      memory leak and building of things we don't even see.

      As BLoc itself is a Stream we can override the close() method of the bloc 
      to close our _StreamSubscription_.
    */
    await _notesStreamSubcription?.cancel();
    return super.close();
  }
}
