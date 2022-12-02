import 'package:flutter/material.dart';
import 'package:Compass_Edge/Nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Infopage extends StatelessWidget {
  const Infopage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        //centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/AppBar/privacy.jpg',
                fit: BoxFit.contain,
                height: 40,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(right: 90, left: 10),
                child: Text('Information'))
          ],
        ),
      ),
      drawer: const NavigationDrawer(),
      body: Center(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(height: 10),
            Text(
              'PRIVACY POLICY',
            ),
          ],
        ),
      ),
    );
  }
}
