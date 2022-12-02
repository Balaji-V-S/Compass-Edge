import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:Compass_Edge/Nav_bar.dart';
import 'package:latlong2/latlong.dart'; //ignore unused refer latlong const value
import 'package:Compass_Edge/sharedPrefs.dart'; //gets value from sharedprefs....
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/AppBar/map.png',
                fit: BoxFit.contain,
                height: 35,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(right: 90, left: 10),
                child: Text('Navigate'))
          ],
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 254, 252, 252),
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      drawer: const NavigationDrawer(),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(13.0, 28.5),
          zoom: 10.0,
          //rotation: 180.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/softrateindia/clafl63i4004h14od6kq7kwle/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGFlN3NyNWMwbnp5M29xbnJoZTJzY2ltIn0.-4deai5HiP1L2mghEp7r5A',
            userAgentPackageName: 'com.example.app',
            additionalOptions: const {
              'accessToken':
                  'pk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGFlN3NyNWMwbnp5M29xbnJoZTJzY2ltIn0.-4deai5HiP1L2mghEp7r5A',
              'id': 'mapbox.mapbox-streets-v8',
            },
          ),
          MarkerLayer(
            markers: [
              Marker(
                  width: 45.0,
                  height: 45.0,
                  point: LatLng(13.0, 28.5),
                  builder: (context) => Container(
                        child: IconButton(
                          icon: const Icon(Icons.location_on),
                          color: Colors.red,
                          iconSize: 45.0,
                          onPressed: () {
                            // ignore: avoid_print
                            print('Marker Pressed');
                          },
                        ),
                      ))
            ],
          )
        ],
      ),
    );
  }
}
