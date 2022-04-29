import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skefra_task_diary/application/notes/note_form/note_form_bloc.dart';

class NotePageFormScaffold extends StatelessWidget {
  const NotePageFormScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NoteFormBloc>();
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NoteFormBloc, NoteFormState>(
          buildWhen: (previous, current) =>
              previous.isEditing != current.isEditing,
          builder: (context, state) =>
              Text(state.isEditing ? 'Edit a Note' : 'Create a Note'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              bloc.add(const NoteFormEvent.saved());
            },
          ),
        ],
      ),
    );
  }
}
