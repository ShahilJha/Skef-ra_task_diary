part of 'note_watcher_bloc.dart';

/*
  _"_NotesReceived"_ is used for switching between _watchAllStarted_ and 
  _watchUncompletedStarted_ event, where both the events require to change events 
  and the stream they are subscribing to with-in the same bloc.

  _"_NotesReceived"_ will be used from with-in the bloc
*/
@freezed
class NoteWatcherEvent with _$NoteWatcherEvent {
  const factory NoteWatcherEvent.watchAllStarted() = _WatchAllStarted;
  const factory NoteWatcherEvent.watchUncompletedStarted() =
      _WatchUncompletedStarted;
  const factory NoteWatcherEvent.notesReceived(
      Either<NoteFailure, KtList<Note>> failureOrNotes) = _NotesReceived;
}
