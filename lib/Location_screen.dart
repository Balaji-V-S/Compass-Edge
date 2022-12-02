import 'package:Compass_Edge/Nav_bar.dart';
import 'package:Compass_Edge/Home_screen.dart';
import 'package:Compass_Edge/mapbox.dart';
//services
import 'dart:developer';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:Compass_Edge/location_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                child: Text('Locate'))
          ],
        ),
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
            Padding(
              padding: const EdgeInsets.only(right: 50, left: 50),
              child: Lottie.asset('assets/Animations/globe.json',
                  height: 350, width: 350),
            ),
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
    );
  }

  TextStyle getStyle({double size = 20}) =>
      TextStyle(fontSize: size, fontWeight: FontWeight.bold);

  void getLocation() async {
    // Obtain shared preferences.

    //----------------------------------------------------//
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
