import 'dart:ui';

import 'package:dartz/dartz.dart';

import '../../core/value_failures/value_failures.dart';
import '../../core/value_objects/value_object.dart';
import '../notes_value_transformers.dart';

class NoteColor extends ValueObject<Color> {
  @override
  final Either<ValueFailure<Color>, Color> value;
  static const List<Color> predefinedColors = [
    Color(0xfffafafa), // canvas
    Color(0xfffa8072), // salmon
    Color(0xfffedc56), // mustard
    Color(0xffd0f0c0), // tea
    Color(0xfffca3b7), // flamingo
    Color(0xff997950), // tortilla
    Color(0xfffffdd0), // cream
  ];

  const NoteColor._(this.value);

  /*
    Since the user will not be able to select a custom color for now, 
    no other validation is required.
    ##But, for latter updates where user can choose a custom color
    still making the color opaque after choosing the color.
    This makes it so even if the user chooses a transparent color,
    the application will not cause an error rather a opaque version 
    of the chosen color will be used
  */
  factory NoteColor(Color input) => NoteColor._(right(makeColorOpaque(input)));
}
