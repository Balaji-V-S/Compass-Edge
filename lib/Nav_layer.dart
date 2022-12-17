import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//pages
import 'package:Compass_Edge/Pages/Home_screen.dart';
import 'package:Compass_Edge/Pages/Location_screen.dart';
import 'package:Compass_Edge/Pages/mapbox.dart';
import 'package:Compass_Edge/Pages/InfoScreen.dart';

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
    const Infopage(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home, color: Colors.white),
      const Icon(Icons.pin_drop, color: Colors.white),
      const Icon(Icons.map, color: Colors.white),
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
