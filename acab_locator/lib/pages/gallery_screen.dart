import 'dart:io' show File, Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late Future<List<String>> _imagePaths;

  @override
  void initState() {
    super.initState();
    _imagePaths = _getSavedImages();
  }

  Future<List<String>> _getSavedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory
        .listSync()
        .where((item) => item.path.endsWith('.jpg'))
        .toList();
    return files.map((file) => file.path).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: FutureBuilder<List<String>>(
        future: _imagePaths,
        builder: (context, snapshot) {
          if (!kIsWeb) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error loading images${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No images found'));
            } else {
              final imagePaths = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Image.file(File(imagePaths[index]), fit: BoxFit.cover);
                },
              );
            }
          } else {
            return const Center(
                child: Text('Gallery not supported on this platform'));
          }
        },
      ),
    );
  }
}
