import 'package:acab_locator/components/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acab Locator'),
      ),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
