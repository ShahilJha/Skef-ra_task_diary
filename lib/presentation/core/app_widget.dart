import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../routes/router.gr.dart' as app_route;
import 'theme_generator.dart';

final GlobalKey<ScaffoldMessengerState> kScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  final router = app_route.Router();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp.router(
      scaffoldMessengerKey: kScaffoldMessengerKey,
      routerDelegate: AutoRouterDelegate(router),
      routeInformationParser: router.defaultRouteParser(),
      title: 'Skef-Ra Task Diary',
      debugShowCheckedModeBanner: false,
      theme: ThemeGenerator.generateThemeData(),
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        breakpoints: const [
          ResponsiveBreakpoint.resize(350, name: MOBILE),
          ResponsiveBreakpoint.autoScale(600, name: TABLET),
          ResponsiveBreakpoint.resize(800, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
        ],
      ),
    );
  }
}
