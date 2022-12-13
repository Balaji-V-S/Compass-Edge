import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math; // to calculate pi val
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:torch_light/torch_light.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:Compass_Edge/Pages/Police.dart';
import 'package:flutter/services.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
//Pages
import 'package:Compass_Edge/Pages/Location_screen.dart';
import 'package:Compass_Edge/Pages/mapbox.dart';
import 'package:Compass_Edge/Pages/Nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

// Since direction keeps changing... a stf widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hasflashlight = true; //to set is there any flashlight ?
  bool isturnon = false; //to set if flash light is on or off
  IconData flashicon = Icons.flashlight_on_sharp; //icon for lashlight button

  void torchLightOff() async {
    try {
      await TorchLight.disableTorch();
    } catch (e) {
      print(e);
    }
  }

  void torchLightOn() async {
    try {
      await TorchLight.enableTorch();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      //we use Future.delayed because there is async function inside it.
      bool istherelight = true;
      setState(() {
        hasflashlight = istherelight;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(45, 47, 65, 1),
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/logo-png.png',
                  fit: BoxFit.contain,
                  height: 40,
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(right: 90, left: 10),
                  child: Text('Compass Edge'))
            ],
          ),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null)
          return const Center(
            child: Text("Device does not have sensors !"),
          );

        int ang = (direction.round());
        return WillPopScope(
          child: Stack(
            children: [
              Container(
                child: GestureDetector(
                  onDoubleTap: () => blinker(),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/police-light.png',
                              height: 45,
                              width: 100,
                            ),
                            Text(
                              'EMERGENCY',
                              style: TextStyle(
                                  color: Colors.grey[300],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: ((ang) * (math.pi / 180) * -1),
                  child: Image.asset(
                    'assets/digicom.png',
                    scale: 0.9,
                  ),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    if (isturnon) {
                      //if light is on, then turn off
                      torchLightOn();
                      setState(() {
                        isturnon = false;
                        flashicon = Icons.flashlight_off_sharp;
                      });
                    } else {
                      //if light is off, then turn on.
                      torchLightOff();
                      setState(() {
                        isturnon = true;
                        flashicon = Icons.flashlight_on_sharp;
                      });
                    }
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 465),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: RadialGradient(
                              colors: [Color(0x9cffffff), Color(0xffb1f6ff)],
                              center: Alignment.center,
                              radius: 0.8,
                            )),
                        child: const Icon(Icons.flashlight_on_sharp),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "$ang",
                  style: const TextStyle(
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
                    color: const Color.fromARGB(186, 245, 4, 4),
                  ),
                ),
              ),
            ],
          ),
          onWillPop: () => _onBackpressed(context),
        );
      },
    );
  }

  Future<bool> _onBackpressed(BuildContext context) async {
    bool? exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Really?"),
            content: const Text("Do you want to exit the App?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("No"),
              )
            ],
          );
        });
    return exitApp ?? false;
  }
}
