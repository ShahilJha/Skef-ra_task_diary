import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';
import 'package:skefra_task_diary/domain/core/value_failures/value_failures.dart';
import 'package:skefra_task_diary/domain/core/value_objects/value_object.dart';
import 'package:skefra_task_diary/domain/notes/notes_value_transformers.dart';
import 'package:skefra_task_diary/domain/notes/notes_value_validators.dart';

class NoteBody extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;
  static const maxLength = 1000;

  const NoteBody._(this.value);

  /*
    if the value of the first validator is a _Failure_ then the _flatMap_ functions are skipped entirely
    ```
      NoteBody._(
        validateMaxStringLength(input, maxLength)
          .flatMap((inputValue) => validateStringNotEmpty(inputValue))
      );
    ```

    Or to simplify we can also write the above code as
    ```
      NoteBody._(validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty));
    ```
    Here, _validateStringNotEmpty()_ has same signature so we can reduce the written code 

    ##This is calle the _Right Bias of Either_

    _Option_ is also right biased
      as if the option is ```some()``` it is gonna continue _flatMapping_ and 
      if the _option_ in ```none()```  then it will not continue _flatMapping_

  */

  factory NoteBody(String input) => NoteBody._(
        validateMaxStringLength(input, maxLength)
            .flatMap(validateStringNotEmpty),
      );
}

class TodoName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;
  static const maxLength = 30;

  const TodoName._(this.value);

  factory TodoName(String input) => TodoName._(
        validateMaxStringLength(input, maxLength)
            .flatMap(validateStringNotEmpty)
            .flatMap(validateSigleLine),
      );
}

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

class TodoList<T> extends ValueObject<KtList<T>> {
  @override
  final Either<ValueFailure<KtList<T>>, KtList<T>> value;
  static const maxLength = 10;

  const TodoList._(this.value);

  factory TodoList(KtList<T> input) =>
      TodoList._(validateMaxListLength(input, maxLength));

  ///Returns the length of the object list and 0 if value failure or empty list
  int get length => value.getOrElse(() => emptyList()).size;

  ///Returns _ture_ if object list is full and _false_ if not
  bool get isFull => length == maxLength;
}
