import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:acab_locator/firebase_options.dart';
import 'package:acab_locator/pages/auth/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'pages/camera_page.dart';
import 'pages/home_page.dart';
import 'pages/gallery_screen.dart';
import 'pages/map.dart';
import 'pages/auth/login.dart';
import 'pages/auth/register.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  cameras = await availableCameras();

  await _checkLocationPermissionAndInitialize();

  final theme = await _loadThemeFromJson();
  final location = await _getCurrentLocation();

  runApp(MyApp(theme: theme, location: location));
}

Future<void> _checkLocationPermissionAndInitialize() async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    throw Exception('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Location permissions are permanently denied.');
  }
}

Future<Position> _getCurrentLocation() async {
  return await Geolocator.getCurrentPosition();
}

Future<ThemeData> _loadThemeFromJson() async {
  final themeStr = await rootBundle.loadString('appainter_theme_light.json');
  final themeJson = jsonDecode(themeStr);
  return ThemeDecoder.decodeThemeData(themeJson)!;
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final Position location;

  const MyApp({super.key, required this.theme, required this.location});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => AccessibilityTools(child: child), //accessibilité
      home: const AuthPage(),
      theme: theme,
      routes: {
        '/camera_page': (context) => CameraPage(cameras: cameras),
        '/display_picture_screen': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String;
          return DisplayPictureScreen(imagePath: args);
        },
        '/gallery': (context) => const GalleryScreen(),
        '/map': (context) => const Map(),
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
      return MaterialPageRoute(builder: (context) => CameraPage(cameras: cameras));
    case '/display_picture_screen':
      final args = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => DisplayPictureScreen(imagePath: args));
    case '/gallery':
      return MaterialPageRoute(builder: (context) => const GalleryScreen());
    case '/map':
      return MaterialPageRoute(builder: (context) => const Map());
    case '/auth/login':
      return MaterialPageRoute(builder: (context) => const Login());
    case '/auth/register':
      return MaterialPageRoute(builder: (context) => Register()); //todo: add register page
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
  }
}
