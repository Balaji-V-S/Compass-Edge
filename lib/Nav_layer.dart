import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//pages
import 'package:Compass_Edge/Home_screen.dart';
import 'package:Compass_Edge/Location_screen.dart';
import 'package:Compass_Edge/mapbox.dart';

class NavBox extends StatefulWidget {
  const NavBox({Key? key}) : super(key: key);

  @override
  State<NavBox> createState() => _NavBoxState();
}

class _NavBoxState extends State<NavBox> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = [
    HomeScreen(),
    LocationState(),
    MapScreen(),
    MapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, color: Colors.white),
      Icon(Icons.pin_drop, color: Colors.white),
      Icon(Icons.map, color: Colors.white),
      Icon(Icons.flash_on_outlined, color: Colors.white),
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.blue,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        //Visuls

        color: Colors.grey.shade900,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
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
