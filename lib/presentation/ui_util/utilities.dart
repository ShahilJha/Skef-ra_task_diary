import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:skefra_task_diary/presentation/routes/router.gr.dart'
    as app_router;
import 'package:skefra_task_diary/presentation/widgets/processing_indicator.dart';
import '../core/app_widget.dart';

@lazySingleton
class Utilities {
  Future showSnackBar({required String text}) async {
    return kScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(text),
      ),
    );
  }

  // Navigator.of(kNavigatorKey.currentState!.context).pop();
  // pop with getIt: getIt<appRouter.Router>().pop()
  // context with getIt: getIt<appRouter.Router>().navigatorKey.currentState!.context

  dynamic showProcessing() {
    return showDialog(
      context: app_router.Router().navigatorKey.currentState!.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ProcessingIndicator();
      },
    );
  }
}
