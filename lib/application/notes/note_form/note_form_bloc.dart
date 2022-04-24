import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:skefra_task_diary/domain/notes/i_note_repository.dart';
import 'package:skefra_task_diary/domain/notes/note_failures.dart';
import 'package:skefra_task_diary/domain/notes/value_objects/note_body.dart';
import 'package:skefra_task_diary/domain/notes/value_objects/note_color.dart';
import 'package:skefra_task_diary/domain/notes/value_objects/todo_list.dart';
import 'package:skefra_task_diary/presentation/pages/notes/note_form/misc/toto_items_presentation_classes.dart';

import '../../../domain/notes/entity/note.dart';

part 'note_form_event.dart';
part 'note_form_state.dart';
part 'note_form_bloc.freezed.dart';

@injectable
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  final INoteRepository _noteRepository;
  NoteFormBloc(this._noteRepository) : super(NoteFormState.initial()) {
    on<_Initialized>((event, emit) {
      event.intitialNoteOption.fold(
        // none()
        () => emit(state),
        //some()
        (intitialNote) => emit(state.copyWith(
          note: intitialNote,
          isEditing: true,
        )),
      );
    });

    on<_BodyChanged>((event, emit) {
      emit(state.copyWith(
        note: state.note.copyWith(body: NoteBody(event.bodyString)),
        saveFailureOrSuccessOption: none(),
      ));
    });

    on<_ColorChanged>((event, emit) {
      emit(state.copyWith(
        note: state.note.copyWith(color: NoteColor(event.color)),
        saveFailureOrSuccessOption: none(),
      ));
    });

    on<_TodosChanged>((event, emit) {
      emit(state.copyWith(
        note: state.note.copyWith(
          todoList: TodoList(
            event.todos.map(
              (primitive) => primitive.toDomain(),
            ),
          ),
        ),
        saveFailureOrSuccessOption: none(),
      ));
    });

    on<_Saved>((event, emit) async {
      Either<NoteFailure, Unit>? failureOrSucess;

      emit(state.copyWith(
        isSaving: true,
        saveFailureOrSuccessOption: none(),
      ));

      if (state.note.failureOption.isNone()) {
        failureOrSucess = state.isEditing
            ? await _noteRepository.update(state.note)
            : await _noteRepository.create(state.note);
      }

      emit(state.copyWith(
        isSaving: false,
        showErrorMessages: true,
        saveFailureOrSuccessOption: optionOf(failureOrSucess),
      ));
    });
  }
}
