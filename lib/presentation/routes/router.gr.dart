// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../pages/notes/notes_overview/notes_overview_page.dart' as _i2;
import '../pages/sign_in/sign_in_page.dart' as _i3;
import '../splash/splash_page.dart' as _i1;

class Router extends _i4.RootStackRouter {
  Router([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    NotesOverviewRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.NotesOverviewPage());
    },
    SignInRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SignInPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(SplashRoute.name, path: '/'),
        _i4.RouteConfig(NotesOverviewRoute.name, path: '/login'),
        _i4.RouteConfig(SignInRoute.name, path: '/login')
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.NotesOverviewPage]
class NotesOverviewRoute extends _i4.PageRouteInfo<void> {
  const NotesOverviewRoute() : super(NotesOverviewRoute.name, path: '/login');

  static const String name = 'NotesOverviewRoute';
}

/// generated route for
/// [_i3.SignInPage]
class SignInRoute extends _i4.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/login');

  static const String name = 'SignInRoute';
}
