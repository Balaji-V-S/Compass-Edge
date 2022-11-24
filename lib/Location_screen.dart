import 'package:Compass_Edge/Nav_bar.dart';
import 'package:Compass_Edge/Home_screen.dart';
import 'package:Compass_Edge/mapbox.dart';
//services
import 'dart:developer';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:Compass_Edge/location_service.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationState extends StatefulWidget {
  const LocationState({Key? key}) : super(key: key);

  @override
  State<LocationState> createState() => _LocationStateState();
}

class _LocationStateState extends State<LocationState> {
  String? lat, long, country, state;

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
        title: const Text('Locate'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 254, 252, 252),
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      drawer: const NavigationDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/Animations/globe.json',
                height: 350, width: 350),
            const SizedBox(height: 2),
            Text('Location Info', style: getStyle(size: 24)),
            const SizedBox(
              height: 20,
            ),
            Text('Latitude: ${lat ?? 'Loading....'}'),
            const SizedBox(
              height: 20,
            ),
            Text('Longitude: ${long ?? 'Loading....'}'),
            const SizedBox(
              height: 20,
            ),
            Text('Country: ${country ?? 'Loading....'}'),
            const SizedBox(
              height: 20,
            ),
            Text('State: ${state ?? 'Loading....'}'),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),

      /*floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.black,
        overlayColor: Colors.transparent,
        overlayOpacity: 0.25,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.person),
            label: 'About-Us',
            onTap: () async {
              var url = 'https://softrateindia.com/';

              if (await canLaunch(url)) {
                await launch(
                  url,
                  forceSafariVC: true,
                  forceWebView: true,
                  enableJavaScript: true,
                );
              }
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.map),
            label: 'Map',
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MapScreen(),
              ));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.home),
            label: 'Home',
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.refresh),
            label: 'Refresh Position',
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LocationState(),
              ));
            },
          ),
        ],
      ),*/
    );
  }

  TextStyle getStyle({double size = 20}) =>
      TextStyle(fontSize: size, fontWeight: FontWeight.bold);

  void getLocation() async {
    final Service = LocationService();
    final LocationData = await Service.getLocation();
    //
    if (LocationData != null) {
      final Placemark = await Service.getPlaceMark(locationData: LocationData);

      setState(() {
        lat = LocationData.latitude!.toStringAsFixed(5);
        long = LocationData.longitude!.toStringAsFixed(5);
        country = Placemark?.country ?? 'Could not get country';
        state = Placemark?.administrativeArea ?? 'Could not get State';
      });
    }
  }
}
