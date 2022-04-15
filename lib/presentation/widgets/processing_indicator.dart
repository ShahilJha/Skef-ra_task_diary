import 'package:flutter/material.dart';

class ProcessingIndicator extends StatelessWidget {
  const ProcessingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        width: 100,
        height: 100,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
