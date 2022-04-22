import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skefra_task_diary/domain/notes/i_note_repository.dart';
import 'package:skefra_task_diary/domain/notes/note_failures.dart';

import '../../../domain/notes/entity/note.dart';

part 'note_actor_event.dart';
part 'note_actor_state.dart';
part 'note_actor_bloc.freezed.dart';

class NoteActorBloc extends Bloc<NoteActorEvent, NoteActorState> {
  final INoteRepository _noteRepository;
  NoteActorBloc(this._noteRepository) : super(const _Initial()) {
    on<_Deleted>(
      (event, emit) async {
        emit(const NoteActorState.actionInProgress());
        final possibleFailure = await _noteRepository.delete(event.note);
        possibleFailure.fold(
          //left failure
          (failure) => emit(NoteActorState.deleteFailure(failure)),
          //right Unit -> success
          (_) => emit(const NoteActorState.deleteSuccess()),
        );
      },
    );
  }
}
