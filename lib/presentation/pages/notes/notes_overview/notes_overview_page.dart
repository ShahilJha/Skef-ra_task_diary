import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skefra_task_diary/application/auth/auth_bloc.dart';
import 'package:skefra_task_diary/application/notes/note_actor/note_actor_bloc.dart';
import 'package:skefra_task_diary/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:skefra_task_diary/injection.dart';
import 'package:skefra_task_diary/presentation/pages/notes/notes_overview/local_widgets/notes_overview_body.dart';
import 'package:skefra_task_diary/presentation/routes/router.dart';
import 'package:skefra_task_diary/presentation/ui_util/utilities.dart';

class NotesOverviewPage extends StatelessWidget {
  const NotesOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(
          create: (context) => getIt<NoteActorBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                unauthenticated: (_) => context.router.replaceNamed(rLogin),
                orElse: () => null,
              );
            },
          ),
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) {
              state.maybeMap(
                deleteFailure: (state) => getIt<Utilities>().showSnackBar(
                  text: state.noteFailure.map(
                    unexpected: (_) =>
                        'Unexpected error occured while deleting. Please contact support.',
                    insufficientPermission: (_) => 'Insufficient Permissions.',
                    unableToDelete: (_) => 'Unable To Delete.',
                    unableToUpdate: (_) => 'Impossible error.',
                  ),
                ),
                orElse: () => null,
              );
            },
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.check_box_outline_blank),
                onPressed: () {},
              ),
              // IconButton(
              //   icon: const Icon(Icons.check_box),
              //   onPressed: () {},
              // ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              //TODO: Navigate to Note-form-page
            },
          ),
          body: const NotesOverviewBody(),
        ),
      ),
    );
  }
}
