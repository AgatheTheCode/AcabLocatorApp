import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<Map> {
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final location = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(location.latitude, location.longitude);
      });
    } catch (e) {
      print("Error getting location: $e");
    } finally {
      if (_currentLocation == null) {
        setState(() {
          _currentLocation = const LatLng(0, 0);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: _currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FlutterMap(
              options: MapOptions(
                initialCenter: _currentLocation!,
                minZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation!,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 40.0,
                          ),
                        ],
                      ),
                      width: 40.0,
                      height: 40.0,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    const point = TapPosition(Offset.zero, Offset.zero);
                    //final latlng = LatLng(point.latitude, point.longitude);
                    print('Tapped');
                  },
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: _currentLocation!,
                      minZoom: 15.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _currentLocation!,
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                  size: 40.0,
                                ),
                              ],
                            ),
                            //on tap show the location
                            width: 40.0,
                            height: 40.0,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          const point = TapPosition(Offset.zero, Offset.zero);
                          //final latlng = LatLng(point.latitude, point.longitude);
                          print('Tapped');
                        },
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: _currentLocation!,
                            minZoom: 15.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                              subdomains: const ['a', 'b', 'c'],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: _currentLocation!,
                                  child: const Column(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.green,
                                        size: 40.0,
                                      ),
                                    ],
                                  ),
                                  width: 40.0,
                                  height: 40.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
