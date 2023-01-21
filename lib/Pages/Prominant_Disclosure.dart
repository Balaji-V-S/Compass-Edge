import 'package:compass_edge/Nav_layer.dart';
import 'package:flutter/material.dart';
import 'package:compass_edge/Pages/Nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:compass_edge/Services/location_service.dart';

class PromiDisclose extends StatelessWidget {
  const PromiDisclose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(height: 50),

              Icon(
                Icons.pin_drop_outlined,
                color: Colors.blue,
                size: 30,
              ),
              const SizedBox(height: 5),
              Text(
                'Use your location',
                style:
                    GoogleFonts.jost(fontSize: 27, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              Text(
                'Compass Edge collects location data to enable\nlive location on Map and Locate feature\n when the app is in use.',
                style: GoogleFonts.jost(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/pin-location.jpg',
                    width: 300,
                  ),
                ),
              ),
              // No thanks button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const NavBox()));
                },
                child: Text(
                  'No Thanks!',
                  style: GoogleFonts.jost(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 15),
              //proceed button
              ElevatedButton(
                onPressed: () {
                  getLocation();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const NavBox()));
                },
                child: Text(
                  'Proceed',
                  style: GoogleFonts.jost(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getLocation() async {
    final Service = LocationService();
    final LocationData = await Service.getLocation();
    //
    // ignore: unnecessary_null_comparison
  }
}
