import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skefra_task_diary/application/notes/note_form/note_form_bloc.dart';
import 'package:skefra_task_diary/domain/notes/value_objects/note_color.dart';

class ColorField extends StatelessWidget {
  const ColorField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteFormBloc, NoteFormState>(
      buildWhen: (previous, current) =>
          previous.note.color != current.note.color,
      builder: (context, state) {
        return SizedBox(
          height: 80,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: NoteColor.predefinedColors.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
            itemBuilder: (context, index) {
              final itemColor = NoteColor.predefinedColors[index];
              return GestureDetector(
                onTap: () => context
                    .read<NoteFormBloc>()
                    .add(NoteFormEvent.colorChanged(itemColor)),
                child: Material(
                  elevation: 4,
                  shape: CircleBorder(
                    side: state.note.color.value.fold(
                      //Failure
                      //! For Future Update of custom color
                      (_) => BorderSide.none,
                      //Valid Color
                      (color) => color == itemColor
                          ? const BorderSide(width: 1.5)
                          : BorderSide.none,
                    ),
                  ),
                  color: itemColor,
                  child: const SizedBox(
                    width: 50,
                    height: 50,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
