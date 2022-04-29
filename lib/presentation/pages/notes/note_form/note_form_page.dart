import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skefra_task_diary/application/notes/note_form/note_form_bloc.dart';
import 'package:skefra_task_diary/domain/notes/entity/note.dart';
import 'package:skefra_task_diary/injection.dart';
import 'package:skefra_task_diary/presentation/ui_util/utilities.dart';
import 'package:skefra_task_diary/presentation/widgets/in_process_overlay.dart';

import 'local_widgets/note_page_form_scaffold_widget.dart';

class NoteFormPage extends StatelessWidget {
  final Note? editedNote;
  const NoteFormPage({Key? key, this.editedNote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NoteFormBloc>()
        ..add(NoteFormEvent.initialized(optionOf(editedNote))),
      child: BlocConsumer<NoteFormBloc, NoteFormState>(
        listenWhen: (previous, current) =>
            previous.saveFailureOrSuccessOption !=
            current.saveFailureOrSuccessOption,
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(
            //none()
            () => null,
            //some()
            (either) => either.fold(
              //failure
              (failure) => getIt<Utilities>().showSnackBar(
                text: failure.map(
                  unexpected: (_) =>
                      'Unexpected Error Occured. Please Contact Support.',
                  insufficientPermission: (_) => 'Insufficient Permissions',
                  unableToDelete: (_) => 'Unable to Delete',
                  unableToUpdate: (_) => 'Unable to Update',
                ),
              ),
              //no failure -> Unit
              (_) {
                context.router.pop();
              },
            ),
          );
        },
        buildWhen: (previous, current) => previous.isSaving != current.isSaving,
        builder: (context, state) {
          return Stack(
            children: [
              const NotePageFormScaffold(),
              InProcessOverlay(inProcess: state.isSaving),
            ],
          );
        },
      ),
    );
  }
}
