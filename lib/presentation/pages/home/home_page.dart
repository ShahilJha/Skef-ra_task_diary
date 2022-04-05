import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.navigateNamedTo('/login');
        },
      ),
      appBar: AppBar(
        title: const Text('dez nuts!'),
        centerTitle: true,
      ),
      body: const Center(child: Text('da fuq!!!')),
    );
  }
}
