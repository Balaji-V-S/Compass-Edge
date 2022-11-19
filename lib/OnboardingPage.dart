import 'package:Compass_Edge/Home_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                body: 'Unleash your thirst for expedetion',
                image: buildImage('assets/Animations/flat-compass.json'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Locate Yourself',
                body: 'Get the coordinates on hands',
                image: buildImage('assets/Animations/globe-on-mobile.json'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Simple UI',
                body: 'Made simple,yet robust !!',
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
                image: buildImage('assets/Animations/travel-icons.json'),
                decoration: getPageDecoration(),
              ),
            ],
            showNextButton: true,
            next: Icon(Icons.arrow_forward_outlined),
            showSkipButton: true,
            skip: Text('Skip'),
            onSkip: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => HomeScreen())),
            isProgressTap: false,
            animationDuration: 500,
            dotsDecorator: getDotdecoration(),
            done: Text(
              'Start',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onDone: () async {
              //Shared prefs context
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', true);
              //Navigation context for on done...
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
      );

  Widget buildImage(String path) => Center(
        child: Lottie.asset(path, width: 450),
      );
  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        imagePadding: EdgeInsets.only(top: 45),
      );

  DotsDecorator getDotdecoration() => DotsDecorator(
        color: Color.fromARGB(255, 120, 117, 121),
        size: Size(7, 7),
        activeSize: Size(12, 12),
        activeColor: Colors.deepPurple[900],
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
}
