import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

void main() {
  runApp(SafeNightWalkApp());
}

class SafeNightWalkApp extends StatefulWidget {
  @override
  _SafeNightWalkAppState createState() => _SafeNightWalkAppState();
}

class _SafeNightWalkAppState extends State<SafeNightWalkApp> {
  late MapController mapController;
  Location location = Location();
  LatLng _currentPosition = LatLng(37.7749, -122.4194); // Default location (San Francisco)

  void _getLocation() async {
    var userLocation = await location.getLocation();
    setState(() {
      _currentPosition = LatLng(userLocation.latitude!, userLocation.longitude!);
    });
    mapController.move(_currentPosition, 15.0);
  }

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Safe Night Walk")),
        body: FlutterMap(
          mapController: mapController,
          // options: MapOptions(
          //   center: _currentPosition,
          //   zoom: 15.0,
          // ),

          options: MapOptions(
  initialCenter: _currentPosition,  // ✅ Correct way in flutter_map 8.x
  initialZoom: 15.0,  // ✅ `initialZoom` replaces `zoom`
),

          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            // MarkerLayer(
            //   markers: [
            //     Marker(
            //       width: 40.0,
            //       height: 40.0,
            //       point: _currentPosition,
            //       builder: (ctx) => Icon(Icons.location_pin, color: Colors.red, size: 40),
            //     ),
            //   ],
            // ),
MarkerLayer(
  markers: [
    Marker(
      point: _currentPosition,
      width: 40.0,
      height: 40.0,
      child: Icon(Icons.location_pin, color: Colors.red, size: 40),
    ),
  ],
)


          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _getLocation,
          child: Icon(Icons.location_searching),
        ),
      ),
    );
  }
}
