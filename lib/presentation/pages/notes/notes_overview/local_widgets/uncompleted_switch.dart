import 'package:flutter/material.dart';

class UncompletedSwitch extends StatelessWidget {
  const UncompletedSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkResponse(
        onTap: () {},
        child: const Icon(Icons.check_box_outline_blank),
      ),
    );
  }
}

 // IconButton(
    //   icon: const Icon(Icons.check_box),
    //   onPressed: () {},
    // ),