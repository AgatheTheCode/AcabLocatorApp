import 'package:acab_locator/components/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acab Locator'),
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to Acab Locator!'),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  text:
                      'Cette application à été créée sur une idée originale de Lucile Pabois. Elle à un but purement éducatif et ne doit pas être utilisée pour des fins commerciales. Aucune personne ne doit être photographiée sans son consentement.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Pour accéder aux fonctionnalités de l\'application, utilisez le menu.',
              ),
            ),
          ],
        ),
        // Add a button to navigate to the camera page
      ),
    );
  }
}
