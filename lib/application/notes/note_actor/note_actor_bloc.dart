import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skefra_task_diary/domain/notes/note_failures.dart';

import '../../../domain/notes/entity/note.dart';

part 'note_actor_event.dart';
part 'note_actor_state.dart';
part 'note_actor_bloc.freezed.dart';

class NoteActorBloc extends Bloc<NoteActorEvent, NoteActorState> {
  NoteActorBloc() : super(const _Initial()) {
    on<_Deleted>(
      (event, emit) {},
    );
  }
}
