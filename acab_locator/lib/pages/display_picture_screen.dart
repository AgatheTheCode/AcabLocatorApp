import 'dart:io';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display Picture')),
      body: Center(
        child: imagePath.isNotEmpty
            ? Image.file(File(imagePath))
            : const Text('No image captured'),
      ),
    );
  }
}
