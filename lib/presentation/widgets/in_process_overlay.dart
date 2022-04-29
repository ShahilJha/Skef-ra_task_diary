import 'package:flutter/material.dart';
import 'package:skefra_task_diary/presentation/widgets/processing_indicator.dart';

class InProcessOverlay extends StatelessWidget {
  final bool inProcess;
  const InProcessOverlay({
    Key? key,
    required this.inProcess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !inProcess,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: inProcess ? Colors.black.withOpacity(0.4) : Colors.transparent,
        child: Visibility(
          visible: inProcess,
          child: const ProcessingIndicator(),
        ),
      ),
    );
  }
}
