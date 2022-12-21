import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:Compass_Edge/Pages/Nav_bar.dart'; //ignore unused refer latlong const value
import 'package:Compass_Edge/Services/location_service.dart';
import 'package:Compass_Edge/Pages/Location_screen.dart';
import 'package:latlong2/latlong.dart';
//import 'package:Compass_Edge/sharedPrefs.dart'; //gets value from sharedprefs....
import 'package:google_fonts/google_fonts.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mapbox Demo',
      home: MapBox(),
    );
  }
}

class MapBox extends StatefulWidget {
  const MapBox({Key? key}) : super(key: key);

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  String? lat, long;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/AppBar/locate.png',
                fit: BoxFit.contain,
                height: 35,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(right: 90, left: 10),
                child: const Text('Locate'))
          ],
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 254, 252, 252),
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      drawer: const NavigationDrawer(),
      body: Container(
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(0.2356, 56.235),
            zoom: 9.2,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/softrateindia/clafl63i4004h14od6kq7kwle/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGFlN3NyNWMwbnp5M29xbnJoZTJzY2ltIn0.-4deai5HiP1L2mghEp7r5A',
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGFlN3NyNWMwbnp5M29xbnJoZTJzY2ltIn0.-4deai5HiP1L2mghEp7r5A',
                'id': 'mapbox.mapbox-streets-v8'
              },
            ),
          ],
        ),
      ),
    );
  }

  void getLocation() async {
    final Service = LocationService();
    final LocationData = await Service.getLocation();
    //
    // ignore: unnecessary_null_comparison
    if (LocationData != null) {
      final Placemark = await Service.getPlaceMark(locationData: LocationData);

      setState(() {
        lat = LocationData.latitude!.toStringAsFixed(5);
        long = LocationData.longitude!.toStringAsFixed(5);
      });
    }
  }
}
