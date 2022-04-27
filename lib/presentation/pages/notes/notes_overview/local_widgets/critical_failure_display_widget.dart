import 'package:flutter/material.dart';
import 'package:skefra_task_diary/domain/notes/note_failures.dart';
import 'package:skefra_task_diary/presentation/widgets/app_button.dart';

class CriticalFailureDisplay extends StatelessWidget {
  final NoteFailure failure;
  const CriticalFailureDisplay({Key? key, required this.failure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error,
            size: 150,
          ),
          Text(
            failure.maybeMap(
              unexpected: (_) => 'Unexpected Error.\nPlease Contact Support.',
              insufficientPermission: (_) => 'Insufficient Permission.',
              orElse: () => 'Unexpected Error.\nPlease Contact Support.',
            ),
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          AppButton(
            name: 'Send Report',
            onPressed: () {
              //TODO: implement error email reporting
            },
          ),
        ],
      ),
    );
  }
}
