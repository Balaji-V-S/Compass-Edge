import 'package:flutter/material.dart';
import 'package:compass_edge/Pages/Police.dart';

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
          child: Container(
            child: Column(
              children: [
                Image.asset(
                  'assets/police-light.png',
                  height: 29,
                  width: 70,
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
    );
  }
}
