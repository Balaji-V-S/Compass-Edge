import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:Compass_Edge/Nav_bar.dart';
import 'package:latlong2/latlong.dart'; //ignore unused refer latlong const value
import 'package:Compass_Edge/location_service.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  double? lat = 0, long = 0;

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
        title: const Text('Navigate'),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 254, 252, 252),
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      drawer: const NavigationDrawer(),
      body: FlutterMap(
        options: MapOptions(
            center: LatLng(lat!, long!),
            zoom: 10.0,
            rotation: 180.0,
            onTap: (LatLng, LatLong) {
              print(LatLong);
            }),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/softrateindia/clafl63i4004h14od6kq7kwle/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGFlN3NyNWMwbnp5M29xbnJoZTJzY2ltIn0.-4deai5HiP1L2mghEp7r5A',
            userAgentPackageName: 'com.example.app',
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGFlN3NyNWMwbnp5M29xbnJoZTJzY2ltIn0.-4deai5HiP1L2mghEp7r5A',
              'id': 'mapbox.mapbox-streets-v8',
            },
          ),
        ],
      ),
    );
  }

  void getLocation() async {
    final Service = LocationService();
    final LocationData = await Service.getLocation();
    //
    if (LocationData != null) {
      setState(() {
        lat = LocationData.latitude!;
        long = LocationData.longitude!;
      });
    }
  }
}
