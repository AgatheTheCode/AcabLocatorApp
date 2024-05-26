<<<<<<< Updated upstream
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:geolocator/geolocator.dart';
>>>>>>> geoloc

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({super.key, required this.cameras});
=======
import 'package:acab_locator/firebase_options.dart';
import 'package:acab_locator/pages/auth/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'pages/camera_page.dart';
import 'pages/display_picture_screen.dart';
import 'pages/home_page.dart';
import 'pages/gallery.dart';
import 'pages/map.dart';
import 'pages/auth/login.dart';
import 'pages/auth/register.dart';

// Make sure to define DefaultFirebaseOptions if you haven't already

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Obtain a list of the available cameras on the device.
  cameras = await availableCameras();
  
  // Load theme from JSON
  final themeStr = await rootBundle.loadString('assets/appainter_theme_light.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  
  // Run the application
  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({super.key, required this.theme});
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< Updated upstream
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'ACAB Locator', cameras: cameras),
    );
  }
}

<<<<<<< HEAD
class MyHomePage extends StatelessWidget {
=======
class MyHomePage extends StatefulWidget {
>>>>>>> geoloc
  final String title;
  final List<CameraDescription> cameras;

  const MyHomePage({super.key, required this.title, required this.cameras});

  @override
<<<<<<< HEAD
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(
        child: Text('Appuyez sur le bouton pour ouvrir la camera.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (cameras.isNotEmpty) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CameraPage(camera: cameras.first),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Aucune caméra disponible.')),
            );
          }
        },
        tooltip: 'Ouvrir la camera',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class CameraPage extends StatefulWidget {
  final CameraDescription camera;

  const CameraPage({super.key, required this.camera});
=======
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;
  String _currentAddress = 'Localisation en cours de recherche...';
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Le service de localisation est désactivé.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("L'accès à la localisation a été refusé.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("L'accès à la localisation a été refusé pour toujours.");
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _currentAddress = 'Lat: ${position.latitude}, Lon: ${position.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_currentAddress),
            const SizedBox(height: 20),
            const Text('Appuyez sur le bouton pour ouvrir la camera.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.cameras.isNotEmpty) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CameraPage(cameras: widget.cameras),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Aucune caméra disponible.')),
            );
          }
=======
      home: const AuthPage(),
      theme: theme,
      routes: {
        '/camera_page': (context) => CameraPage(cameras: cameras),
        '/display_picture_screen': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String;
          return DisplayPictureScreen(imagePath: args);
>>>>>>> Stashed changes
        },
        '/gallery': (context) => Gallery(),
        '/map': (context) => Map(),
        '/auth/login': (context) => const Login(),
        '/auth/register': (context) => Register(),
      },
      onGenerateRoute: generateRoute,
    );
  }
}

<<<<<<< Updated upstream
class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraPage({super.key, required this.cameras});
>>>>>>> geoloc

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
<<<<<<< HEAD
=======
  late CameraDescription _currentCamera;
>>>>>>> geoloc

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _controller = CameraController(
      widget.camera,
=======
    _currentCamera = widget.cameras.first;
    _initializeCamera();
  }

  void _initializeCamera() {
    _controller = CameraController(
      _currentCamera,
>>>>>>> geoloc
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
<<<<<<< HEAD
=======
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
>>>>>>> geoloc
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(title: const Text('Camera')),
=======
      appBar: AppBar(
        title: const Text('Camera'),
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_camera),
            onPressed: _switchCamera,
          ),
        ],
      ),
>>>>>>> geoloc
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
<<<<<<< HEAD
=======
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
>>>>>>> geoloc
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        tooltip: 'Prendre une photo',
        child: const Icon(Icons.camera),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Afficher la photo')),
      body: Image.file(File(imagePath)),
    );
=======
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const HomePage());
    case '/camera_page':
      return MaterialPageRoute(builder: (context) => CameraPage(cameras: cameras));
    case '/display_picture_screen':
      final args = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => DisplayPictureScreen(imagePath: args));
    case '/gallery':
      return MaterialPageRoute(builder: (context) => Gallery());
    case '/map':
      return MaterialPageRoute(builder: (context) => Map());
    case '/auth/login':
      return MaterialPageRoute(builder: (context) => const Login());
    case '/auth/register':
      return MaterialPageRoute(builder: (context) => Register());
    default:
      return MaterialPageRoute(builder: (context) => const HomePage());
>>>>>>> Stashed changes
  }
}
