import 'package:flutter/material.dart';
import 'package:kt_dart/kt.dart';
import 'package:skefra_task_diary/presentation/pages/notes/note_form/misc/toto_items_presentation_classes.dart';

/*
  _ValueNotifier_ is a _ChangeNotifier_ used here to pull up the state of the list,
  so we can perform all operation in Form UI using a single 
  _KtList<TodoItemPrimitive>_ list.
*/

class FormTodos extends ValueNotifier<KtList<TodoItemPrimitive>> {
  //for default value at instantiation
  FormTodos() : super(emptyList<TodoItemPrimitive>());
}
