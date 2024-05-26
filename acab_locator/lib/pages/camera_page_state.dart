import 'package:acab_locator/pages/camera_page.dart';
import 'package:acab_locator/pages/display_picture_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  late CameraDescription _currentCamera;

  @override
  void initState() {
    super.initState();
    _currentCamera = widget.cameras.first;
    _initializeCamera();
  }

  void _initializeCamera() {
    _controller = CameraController(
      _currentCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      if (!mounted) return;

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(imagePath: image.path),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  void _switchCamera() {
    setState(() {
      if (_currentCamera == widget.cameras.first) {
        _currentCamera = widget.cameras.last;
      } else {
        _currentCamera = widget.cameras.first;
      }
      _initializeCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_camera),
            onPressed: _switchCamera,
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        tooltip: 'Prendre une photo',
        child: const Icon(Icons.camera),
      ),
    );
  }
}
