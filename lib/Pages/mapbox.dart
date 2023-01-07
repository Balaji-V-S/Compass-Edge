import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:Compass_Edge/Pages/Nav_bar.dart'; //ignore unused refer latlong const value
import 'package:Compass_Edge/Services/location_service.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
                child: Text('Navigate',
                    style: GoogleFonts.jost(
                        fontSize: 20, fontWeight: FontWeight.bold)))
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
            center: LatLng(double.parse(lat!), double.parse(long!)),
            zoom: 20.0,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/softrateindia/clcj9767h00lr14s1gqblmxu3/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGFlN3NyNWMwbnp5M29xbnJoZTJzY2ltIn0.-4deai5HiP1L2mghEp7r5A',
              additionalOptions: const {
                'accessToken':
                    'pk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGFlN3NyNWMwbnp5M29xbnJoZTJzY2ltIn0.-4deai5HiP1L2mghEp7r5A',
                'id': 'mapbox.mapbox-streets-v8'
              },
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(double.parse(lat!), double.parse(long!)),
                  width: 40,
                  height: 40,
                  builder: (context) => Image.asset('assets/livemarker.png'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        children: [
          SpeedDialChild(
            child: const Icon(CupertinoIcons.globe),
            label: 'Satellite',
            onTap: () {
              setState(() {});
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.add_home_work_outlined),
            label: 'Street',
            onTap: () {
              setState(() {});
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.add_road),
            label: 'Navigation',
            onTap: () {
              setState(() {});
            },
          ),
        ],
        child: const Icon(Icons.layers_outlined),
      ),
    );
  }

  void getLocation() async {
    // ignore: non_constant_identifier_names
    final Service = LocationService();
    // ignore: non_constant_identifier_names
    final LocationData = await Service.getLocation();
    //
    // ignore: unnecessary_null_comparison
    if (LocationData != null) {
      final Placemark = await Service.getPlaceMark(locationData: LocationData);

      setState(() {
        lat = LocationData.latitude!.toStringAsFixed(7);
        long = LocationData.longitude!.toStringAsFixed(7);
      });
    }
  }
}
