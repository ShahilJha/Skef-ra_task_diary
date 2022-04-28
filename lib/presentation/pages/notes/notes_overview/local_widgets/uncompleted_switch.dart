import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:skefra_task_diary/application/notes/note_watcher/note_watcher_bloc.dart';

class UncompletedSwitch extends HookWidget {
  const UncompletedSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toggleState = useState(false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkResponse(
        onTap: () {
          toggleState.value = !toggleState.value;
          context.read<NoteWatcherBloc>().add(
                toggleState.value
                    ? const NoteWatcherEvent.watchUncompletedStarted()
                    : const NoteWatcherEvent.watchAllStarted(),
              );
        },
        child: AnimatedSwitcher(
          duration: const Duration(microseconds: 100),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          //TODO: fix: animation not working
          child: toggleState.value
              ? const Icon(
                  Icons.check_box,
                  key: Key('check_box'),
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  key: Key('check_box_ouline_blank'),
                ),
        ),
      ),
    );
  }
}
