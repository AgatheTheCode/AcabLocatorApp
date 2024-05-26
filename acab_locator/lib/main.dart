import 'dart:io';

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
  final themeStr =
      await rootBundle.loadString('assets/appainter_theme_light.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  // Run the application
  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthPage(),
      theme: theme,
      routes: {
        '/camera_page': (context) => CameraPage(cameras: cameras),
        '/display_picture_screen': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String;
          return DisplayPictureScreen(imagePath: args);
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

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const HomePage());
    case '/camera_page':
      return MaterialPageRoute(
          builder: (context) => CameraPage(cameras: cameras));
    case '/display_picture_screen':
      final args = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(imagePath: args));
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
