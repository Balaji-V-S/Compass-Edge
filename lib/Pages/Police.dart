// ignore: file_names
// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:compass_edge/Nav_layer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phlox_animations/phlox_animations.dart';

class blinker extends StatelessWidget {
  const blinker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Stack(
        children: [
          // blue
          PhloxAnimations(
            duration: const Duration(milliseconds: 200),
            loop: true,
            fromOpacity: 0,
            toOpacity: 1,
            wait: const Duration(seconds: 1),
            child: Container(
              height: height,
              width: width,
              color: const Color.fromARGB(255, 1, 92, 249),
            ),
          ),
          // red
          PhloxAnimations(
            duration: const Duration(milliseconds: 200),
            loop: true,
            fromOpacity: 0,
            toOpacity: 1,
            wait: const Duration(seconds: 1),
            child: Container(
              height: height,
              width: width,
              color: const Color.fromARGB(255, 234, 56, 43),
            ),
          ),
        ],
      ),
      onWillPop: () => _onbackpressed(context),
    );
  }

  ////////////-------------------------back to home button Code-----------------/////////////
  Future<bool> _onbackpressed(BuildContext context) async {
    bool? exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Really?",
              style: GoogleFonts.jost(),
            ),
            content: Text(
              "Do you want to exit the App?",
              style: GoogleFonts.jost(),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(
                  "Yes",
                  style: GoogleFonts.jost(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  "No",
                  style: GoogleFonts.jost(color: Colors.black),
                ),
              )
            ],
          );
        });
    return exitApp ?? false;
  }
}
