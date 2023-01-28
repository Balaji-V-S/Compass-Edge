// ignore_for_file: non_constant_identifier_names

import 'package:compass_edge/Pages/Nav_bar.dart';
import 'package:geocoding/geocoding.dart';
//services
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:compass_edge/Services/Admobclass.dart';
import 'dart:developer';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:compass_edge/Services/location_service.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationState extends StatefulWidget {
  const LocationState({Key? key}) : super(key: key);

  @override
  State<LocationState> createState() => _LocationStateState();
}

class _LocationStateState extends State<LocationState> {
  String? lat, long, country, state;
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  late BannerAd _banner;

  @override
  void initState() {
    super.initState();
    _createBannerAd();
    _CreateInterstitialAd();
  }

  void _createBannerAd() {
    //Dedicated Banner Ad unit for this page : )
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
  void _CreateInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdMobService.interstitialAdUnitId!,
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
          drawer: const NavDrawer(),
          body: Center(
            child: Container(
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: Image(
                      image: AssetImage('assets/location-bg.png'),
                      opacity: AlwaysStoppedAnimation(.4),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: 52,
                    child: AdWidget(ad: _banner),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Lottie.asset('assets/Animations/globe.json',
                              height: 250, width: 250),
                        ),
                        const SizedBox(height: 2),
                        Text('Location Info', style: getStyle(size: 24)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Latitude: ${lat ?? 'Loading....'}',
                            style: GoogleFonts.jost(fontSize: 15)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Longitude: ${long ?? 'Loading....'}',
                            style: GoogleFonts.jost(fontSize: 15)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Country: ${country ?? 'Loading....'}',
                            style: GoogleFonts.jost(fontSize: 15)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('State: ${state ?? 'Loading....'}',
                            style: GoogleFonts.jost(fontSize: 15)),
                        ElevatedButton.icon(
                          onPressed: () {
                            getLocation();
                            _showInterstitialAd();
                          },
                          icon: Icon(Icons.pin_drop),
                          label: Text(
                            'Get Location',
                            style: GoogleFonts.jost(fontSize: 15),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () => _onbackpressed(context));
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
