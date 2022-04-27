import 'package:flutter/material.dart';
import 'package:skefra_task_diary/global_constants.dart';

class ProcessingIndicator extends StatelessWidget {
  final bool? neumorphic;
  const ProcessingIndicator({Key? key, this.neumorphic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: kScaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: neumorphic ?? false
              ? const [
                  BoxShadow(
                    color: kScaffoldBackgroundColorDarkShadow,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        width: 100,
        height: 100,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
