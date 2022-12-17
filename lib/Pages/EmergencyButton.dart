import 'package:flutter/material.dart';
import 'package:Compass_Edge/Pages/Police.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onDoubleTap: () {
          Navigator.pop(context);

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const blinker()));
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: 30,
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
                        color: Colors.grey[300], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
