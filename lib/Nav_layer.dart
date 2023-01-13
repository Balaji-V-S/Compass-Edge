// ignore: file_names
import 'package:compass_edge/Pages/Police.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//pages
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:compass_edge/Pages/Home_screen.dart';
import 'package:compass_edge/Pages/Location_screen.dart';
import 'package:compass_edge/Pages/mapbox.dart';
import 'package:compass_edge/Pages/InfoScreen.dart';

class NavBox extends StatefulWidget {
  const NavBox({Key? key}) : super(key: key);

  @override
  State<NavBox> createState() => _NavBoxState();
}

class _NavBoxState extends State<NavBox> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = [
    const HomeScreen(),
    const LocationState(),
    const MapScreen(),
    const blinker(),
    const Infopage(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(CupertinoIcons.compass, color: Colors.white),
      const Icon(CupertinoIcons.map_pin_ellipse, color: Colors.white),
      const Icon(Icons.map, color: Colors.white),
      const Icon(Icons.sos, color: Colors.white),
      const Icon(Icons.account_circle_outlined, color: Colors.white),
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        //Visuls

        color: Colors.grey.shade900,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        //functionality
        key: navigationKey,
        items: items,
        index: index,
        height: 55,
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}
