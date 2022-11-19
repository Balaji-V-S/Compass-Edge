import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:Compass_Edge/Home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: MediaQuery.of(context).size.height,
      splash: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.cyanAccent.shade100.withOpacity(.6),
              Colors.lightBlueAccent.shade100.withOpacity(.4)
            ],
          ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Container(
                height: 400,
                width: 400,
                child: Image.asset(
                  'assets/new-logo.png',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'from',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 46, 55, 68),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        child: Image.asset(
                          'assets/company-logo.png',
                        ),
                      ),
                      ShaderMask(
                        shaderCallback: (Rect rect) {
                          return LinearGradient(colors: [
                            Colors.purple,
                            Colors.purpleAccent,
                            Colors.pinkAccent
                          ]).createShader(rect);
                        },
                        child: Text(
                          'Softrate',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      nextScreen: HomeScreen(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
