import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:skefra_task_diary/application/notes/note_form/note_form_bloc.dart';
import 'package:skefra_task_diary/domain/notes/value_objects/note_body.dart';
import 'package:skefra_task_diary/presentation/widgets/app_text_field.dart';

/*
  In ther following code:
  ```
    listenWhen: (previous, current) =>
      previous.isEditing != current.isEditing,
    listener: (context, state) {
      textEditingController.text = state.note.body.getOrCrash();
    },
  ```
  we might think that the assignment of
  ```
   textEditingController.text = state.note.body.getOrCrash();
  ```
  will crash the application when the _NoteBody('')_ from the 
  state will cause the app to crash.
  But, in the _NoteFormBLoc_ 
  ```
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
  ```
  and the initial state of _NoteFormState_:
  ```
     factory NoteFormState.initial() => NoteFormState(
          note: Note.empty(),
          showErrorMessages: false,
          isEditing: false,
          isSaving: false,
          saveFailureOrSuccessOption: none(),
        );
  ```
  We can use the _"isEditing"_ variable to determine if the listener should
  be executed or not:
  ```
    listenWhen: (previous, current) => previous.isEditing != current.isEditing,
  ```

  Since, the listener is executed only when the previous, i.e. _initial_, state _false_
  is changed to current, i.e. _initialized_ state _true_, which is assumped to have a 
  proper format of data, allows for this code to run safely.

  In case of any external tampering, the app will crash.

*/

class BodyField extends HookWidget {
  const BodyField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<NoteFormBloc>();
    final textEditingController = useTextEditingController();
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        textEditingController.text = state.note.body.getOrCrash();
      },
      child: AppTextField(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        controller: textEditingController,
        hintText: 'Note Body',
        maxLength: NoteBody.maxLength,
        counterText: '',
        maxLines: null,
        minLines: 5,
        roundBorder: false,
        textAlign: TextAlign.start,
        onChanged: (value) => _bloc.add(NoteFormEvent.bodyChanged(value)),
        validator: (_) => _bloc.state.note.body.value.fold(
          //leftFailure
          (leftFailure) => leftFailure.maybeMap(
            core: (valueFailure) => valueFailure.coreFailure.maybeMap(
              exceedingLength: (failure) =>
                  'Exceeding Length, Max: ${failure.max}',
              empty: (_) => 'Empty Body',
              orElse: () => null,
            ),
            orElse: () => null,
          ),
          //rightValue
          (_) => null,
        ),
      ),
    );
  }
}
