// ignore_for_file: non_constant_identifier_names

import 'package:compass_edge/Services/Admobclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:compass_edge/Pages/Nav_bar.dart'; //ignore unused refer latlong const value
import 'package:compass_edge/Services/location_service.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:latlong2/latlong.dart';
//import 'package:Compass_Edge/sharedPrefs.dart'; //gets value from sharedprefs....
import 'package:google_fonts/google_fonts.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mapbox Demo',
      home: MapBox(),
    );
  }
}

class MapBox extends StatefulWidget {
  const MapBox({Key? key}) : super(key: key);

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  InterstitialAd? _interstitialAd;
  String? lat, long, AdId = 'ca-app-pub-6556402405172089/6954783405';
  String? style =
      'https://api.mapbox.com/styles/v1/softrateindia/clcj9767h00lr14s1gqblmxu3/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGFlN3NyNWMwbnp5M29xbnJoZTJzY2ltIn0.-4deai5HiP1L2mghEp7r5A';

  @override
  void initState() {
    super.initState();
    getLocation();
    _CreateInterstitialAd();
  }

  void _CreateInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdId!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) => _interstitialAd = ad,
          onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
        ));
    _showInterstitialAd();
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _CreateInterstitialAd();
      });
      _interstitialAd!.show();
      _interstitialAd = null;
      _CreateInterstitialAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
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
                    child: Text('Navigate',
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
          drawer: const NavDrawer(),
          body: Container(
            child: FlutterMap(
              options: MapOptions(
                  center: LatLng(double.parse(lat!), double.parse(long!)),
                  keepAlive: true,
                  zoom: 16.0,
                  maxZoom: 18.0),
              children: [
                TileLayer(
                  urlTemplate: '$style',
                  additionalOptions: const {
                    'accessToken':
                        'sk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGNtd2l6N3YwOXBtM3hxcG1lNGJkN2Q1In0.LzK7JeZGG6YB5mQpkufzag',
                    'id': 'mapbox.mapbox-streets-v8'
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(double.parse(lat!), double.parse(long!)),
                      width: 40,
                      height: 40,
                      builder: (context) =>
                          Image.asset('assets/livemarker.png'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: SpeedDial(
              icon: CupertinoIcons.layers_alt,
              backgroundColor: Colors.black,
              overlayColor: Colors.transparent,
              overlayOpacity: 0.0,
              spacing: 10,
              children: [
                SpeedDialChild(
                  child: Icon(CupertinoIcons.car_detailed),
                  label: 'Navigation',
                  labelStyle: GoogleFonts.comfortaa(),
                  onTap: () {
                    _showInterstitialAd();
                    setState(() {
                      style =
                          'https://api.mapbox.com/styles/v1/softrateindia/clcj9g1hx001614o352z1qy1b/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGFlN3NyNWMwbnp5M29xbnJoZTJzY2ltIn0.-4deai5HiP1L2mghEp7r5A';
                    });
                  },
                ),
                SpeedDialChild(
                    child: Icon(CupertinoIcons.location_fill),
                    label: 'Street',
                    labelStyle: GoogleFonts.comfortaa(),
                    onTap: () {
                      _showInterstitialAd();
                      setState(() {
                        style =
                            'https://api.mapbox.com/styles/v1/softrateindia/clafl63i4004h14od6kq7kwle/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGFlN3NyNWMwbnp5M29xbnJoZTJzY2ltIn0.-4deai5HiP1L2mghEp7r5A';
                      });
                    }),
                SpeedDialChild(
                  child: Icon(CupertinoIcons.globe),
                  label: 'Satellite',
                  labelStyle: GoogleFonts.comfortaa(),
                  onTap: () {
                    _showInterstitialAd();
                    setState(() {
                      style =
                          'https://api.mapbox.com/styles/v1/softrateindia/clcj9767h00lr14s1gqblmxu3/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic29mdHJhdGVpbmRpYSIsImEiOiJjbGFlN3NyNWMwbnp5M29xbnJoZTJzY2ltIn0.-4deai5HiP1L2mghEp7r5A';
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        onWillPop: () => _onbackpressed(context));
  }

  void getLocation() async {
    // ignore: non_constant_identifier_names
    final Service = LocationService();
    // ignore: non_constant_identifier_names
    final LocationData = await Service.getLocation();
    //
    // ignore: unnecessary_null_comparison
    if (LocationData != null) {
      final Placemark = await Service.getPlaceMark(locationData: LocationData);

      setState(() {
        lat = LocationData.latitude!.toStringAsFixed(7);
        long = LocationData.longitude!.toStringAsFixed(7);
      });
    }
  }

  ///////////////////////----------------exit-app---------------------------/////////////////////////
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
