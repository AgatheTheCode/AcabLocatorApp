import 'package:acab_locator/components/custom_drawer.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WIP'),
      ),
            drawer: const CustomDrawer(),

      body: const Center(
        child: Text('Register Page WIP'),
      ),
    );
  }
}
