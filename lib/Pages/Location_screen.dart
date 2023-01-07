// ignore_for_file: non_constant_identifier_names

import 'package:Compass_Edge/Pages/Nav_bar.dart';
import 'package:Compass_Edge/Pages/Home_screen.dart';
import 'package:Compass_Edge/Pages/mapbox.dart';
import 'package:geocoding/geocoding.dart';
//services
import 'dart:developer';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:Compass_Edge/Services/location_service.dart';
import 'package:google_fonts/google_fonts.dart';

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
                child: Text('Locate',
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
      body: Center(
        child: Container(
          decoration: const BoxDecoration(),
          child: Stack(
            children: [
              const Positioned.fill(
                //
                child: Image(
                  image: AssetImage('assets/location-bg.png'),
                  opacity: AlwaysStoppedAnimation(.4),
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 40, left: 40),
                    child: Lottie.asset('assets/Animations/globe.json'),
                  ),
                  const SizedBox(height: 2),
                  Text('Location Info', style: getStyle(size: 24)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Latitude: ${lat ?? 'Loading....'}',
                      style: GoogleFonts.jost(fontSize: 15)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Longitude: ${long ?? 'Loading....'}',
                      style: GoogleFonts.jost(fontSize: 15)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Country: ${country ?? 'Loading....'}',
                      style: GoogleFonts.jost(fontSize: 15)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('State: ${state ?? 'Loading....'}',
                      style: GoogleFonts.jost(fontSize: 15)),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle getStyle({double size = 20}) =>
      GoogleFonts.archivo(fontSize: size, fontWeight: FontWeight.bold);

  void getLocation() async {
    final Service = LocationService();
    final LocationData = await Service.getLocation();
    //
    // ignore: unnecessary_null_comparison
    if (LocationData != null && Placemark != null) {
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
