import 'package:compass_edge/Pages/EmergencyButton.dart';
import 'package:compass_edge/Services/Admobclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math; // to calculate pi val
import 'package:google_mobile_ads/google_mobile_ads.dart';
//Pages
import 'package:compass_edge/Pages/torch.dart';
import 'package:compass_edge/Pages/Nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

// Since direction keeps changing... a stf widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd _banner;
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  void _createBannerAd() {
    _banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          _isAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
      }),
      request: const AdRequest(),
    );

    _banner.load();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/logo-png-circle.png',
                  fit: BoxFit.contain,
                  scale: 10,
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(right: 90, left: 10),
                  child: Text('Compass Edge',
                      style: GoogleFonts.jost(
                          fontSize: 20, fontWeight: FontWeight.bold)))
            ],
          ),
        ),
        drawer: const NavigationDrawer(),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 93, 172, 236),
                Color.fromARGB(255, 83, 105, 226)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Builder(builder: (context) {
            return Column(
              children: <Widget>[
                Expanded(child: _buildCompass()),
              ],
            );
          }),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 56),
          child: Container(
            height: 52,
            child: AdWidget(ad: _banner),
          ),
        ),
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
        //print(direction);
        // if direction is 0.000, then device does not support this sensor
        // show error message
        if (direction == 0.000) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          return WillPopScope(
            child: Stack(
              children: [
                //Container(height: 45, child: const Emergency()),
                Padding(
                  padding: const EdgeInsets.only(top: 160),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/Compass_null.png',
                      scale: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 350),
                    child: Column(
                      children: [
                        Text(
                          'OOPS! Magnetometer is missing on your device,\n Unsupported Magnetometer and Altimeter',
                          style: GoogleFonts.jost(
                              fontSize: 17, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          CupertinoIcons.compass,
                          size: 40,
                        )
                      ],
                    ),
                  )),
                ),
                const SizedBox(height: 10),
                Container(
                  child: Builder(builder: (context) {
                    return Column(
                      children: <Widget>[
                        const Expanded(child: TorchButton()),
                      ],
                    );
                  }),
                ),
                // Positioned(
                //   bottom: 55,
                //   child: Container(
                //     height: 52,
                //     child: AdWidget(ad: _banner),
                //   ),
                // ),
              ],
            ),
            onWillPop: () => _onbackpressed(context),
          );
        } else {
          int ang = (direction!.round());
          return WillPopScope(
            child: Stack(
              children: [
                //Container(height: 45, child: const Emergency()),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: ((ang) * (math.pi / 180) * -1),
                    child: Image.asset(
                      'assets/digicom.png',
                      scale: 0.9,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: Builder(builder: (context) {
                    return Column(
                      children: <Widget>[
                        const Expanded(child: TorchButton()),
                      ],
                    );
                  }),
                ),
                Center(
                  child: Text(
                    "$ang",
                    style: GoogleFonts.anton(
                      color: const Color(0xFFEBEBEB),
                      fontSize: 50,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 55),
                //   child: Container(
                //     height: 52,
                //     child: AdWidget(ad: _banner),
                //   ),
                // ),
              ],
            ),
            onWillPop: () => _onbackpressed(context),
          );
        }
      },
    );
  }

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
