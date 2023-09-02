import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:Compass_Edge/Home_screen.dart';
import 'package:compass_edge/Pages/splash_Screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
//Google Ad services
import 'package:google_mobile_ads/google_mobile_ads.dart';

//stores the data in local system
late SharedPreferences sharedPreferences;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: showHome ? const SplashScreen() : const OnBoardingPage(),
      );
}

//------------------------------------------------------------------------------------------------------------------------------//

//-----------------------------------------------------------------------------------------------------------------------------//
/// Onboarding page class........

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
            pages: [
              PageViewModel(
                title: 'Compass Edge',
                body: 'Unleash your thirst for expedition',
                image: buildImage('assets/Animations/flat-compass.json'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Locate Yourself',
                body: 'Get the coordinates & Elevation \n on hands',
                image: buildImage('assets/Animations/globe-on-mobile.json'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Simple UI',
                body: 'Made simple, yet robust !!',
                image: buildImage('assets/Animations/uiux-design.json'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Discover New Places',
                body:
                    "Where you go becomes a part of you somehow.\nYou'll never know until you go",
                image: buildImage('assets/Animations/journey.json'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Navigate On The Go',
                body: 'Navigate your world faster and easier with Compass Edge',
                image: Lottie.asset(
                  'assets/Animations/mapnav.json', /*height: 600, width: 400*/
                ),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Ready to get onboard?',
                body: 'Live with no excuses and travel with no regrets!',
                image: buildImage('assets/Animations/app-scooter.json'),
                decoration: getPageDecoration(),
              ),
            ],
            showNextButton: true,
            next: const Icon(
              Icons.arrow_forward_outlined,
              color: Colors.black,
            ),
            showSkipButton: true,
            skip: const Text(
              'SKIP',
              style: TextStyle(color: Colors.black),
            ),
            onSkip: () async {
              //set the direct state to home-shared prefs
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', true);
              //to push the home screen
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const SplashScreen()));
            },
            isProgressTap: false,
            animationDuration: 500,
            dotsDecorator: getDotdecoration(),
            done: const Text(
              'Start',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            onDone: () async {
              //Shared prefs context
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', true);
              //Navigation context for on done...
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const SplashScreen()));
            }),
      );

  Widget buildImage(String path) => Center(
        child: Lottie.asset(path, width: 450),
      );
  PageDecoration getPageDecoration() => const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        imagePadding: EdgeInsets.only(top: 45),
      );

  DotsDecorator getDotdecoration() => DotsDecorator(
        color: const Color.fromARGB(255, 120, 117, 121),
        size: const Size(7, 7),
        activeSize: const Size(12, 12),
        activeColor: Colors.deepPurple[900],
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
}
