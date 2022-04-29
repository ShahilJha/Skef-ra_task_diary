// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../../domain/notes/entity/note.dart' as _i7;
import '../pages/notes/note_form/note_form_page.dart' as _i4;
import '../pages/notes/notes_overview/notes_overview_page.dart' as _i2;
import '../pages/sign_in/sign_in_page.dart' as _i3;
import '../splash/splash_page.dart' as _i1;

class Router extends _i5.RootStackRouter {
  Router([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    NotesOverviewRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.NotesOverviewPage());
    },
    SignInRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SignInPage());
    },
    NoteFormRoute.name: (routeData) {
      final args = routeData.argsAs<NoteFormRouteArgs>(
          orElse: () => const NoteFormRouteArgs());
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.NoteFormPage(key: args.key, editedNote: args.editedNote),
          fullscreenDialog: true);
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(SplashRoute.name, path: '/'),
        _i5.RouteConfig(NotesOverviewRoute.name, path: '/notesOverview'),
        _i5.RouteConfig(SignInRoute.name, path: '/login'),
        _i5.RouteConfig(NoteFormRoute.name, path: '/notesForm')
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.NotesOverviewPage]
class NotesOverviewRoute extends _i5.PageRouteInfo<void> {
  const NotesOverviewRoute()
      : super(NotesOverviewRoute.name, path: '/notesOverview');

  static const String name = 'NotesOverviewRoute';
}

/// generated route for
/// [_i3.SignInPage]
class SignInRoute extends _i5.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/login');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i4.NoteFormPage]
class NoteFormRoute extends _i5.PageRouteInfo<NoteFormRouteArgs> {
  NoteFormRoute({_i6.Key? key, _i7.Note? editedNote})
      : super(NoteFormRoute.name,
            path: '/notesForm',
            args: NoteFormRouteArgs(key: key, editedNote: editedNote));

  static const String name = 'NoteFormRoute';
}

class NoteFormRouteArgs {
  const NoteFormRouteArgs({this.key, this.editedNote});

  final _i6.Key? key;

  final _i7.Note? editedNote;

  @override
  String toString() {
    return 'NoteFormRouteArgs{key: $key, editedNote: $editedNote}';
  }
}
