import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math; // to calculate pi val
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
//Pages
import 'package:Compass_Edge/Location_screen.dart';
import 'package:Compass_Edge/mapbox.dart';
import 'package:Compass_Edge/Nav_bar.dart';

// Since direction keeps changing... a stf widget

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0XFF2D2F41),
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          centerTitle: true,
          title: Text("Compass Edge"),
        ),
        drawer: const NavigationDrawer(),
        body: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Expanded(child: _buildCompass()),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCompass() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // might need to accound for padding on iphones
    //var padding = MediaQuery.of(context).padding;
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null)
          return Center(
            child: Text("Device does not have sensors !"),
          );

        int ang = (direction.round());
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              /*decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEBEBEB),
              ),*/
              child: Transform.rotate(
                angle: ((direction ?? 0) * (math.pi / 180) * -1),
                child: Image.asset('assets/digicom.png'),
              ),
            ),
            Center(
              child: Text(
                "$ang",
                style: TextStyle(
                  color: Color(0xFFEBEBEB),
                  fontSize: 56,
                ),
              ),
            ),
            Positioned(
              // center of the screen - half the width of the rectangle
              left: (width / 2) - ((width / 80) / 2),
              // height - width is the non compass vertical space, half of that
              top: (height - width) / 2,
              child: SizedBox(
                width: width / 80,
                height: width / 10,
                child: Container(
                  //color: HSLColor.fromAHSL(0.85, 0, 0, 0.05).toColor(),
                  color: Color(0xBBEBEBEB),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
