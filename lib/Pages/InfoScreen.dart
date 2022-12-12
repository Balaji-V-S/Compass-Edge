import 'package:flutter/material.dart';
import 'package:Compass_Edge/Pages/Nav_bar.dart';
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
                child: const Text('Information'))
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
              style: GoogleFonts.lato(
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/security.png'),
            const SizedBox(height: 15),
            const Text('Are you concerned about data security?'),
            const SizedBox(height: 10),
            const Text(
                "Relax! It's Softrate, and we won't gather any user data"),
            const SizedBox(height: 30),
            const Text(
              'We Keep Your Information \nPrivate,Safe and \nSecured',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
                'Softrate respects and protects your privacy through \n industry-leading security infrastructure, responsible \n data practises, and simple privacy tools \n that put you in control.',
                textAlign: TextAlign.center),
            const SizedBox(
              height: 15,
            ),
            // ignore: unnecessary_new
            new Center(
              child: Image.asset('assets/company-logo.png', width: 130),
            ),
            const SizedBox(height: 20),
            const Text('')
          ],
        ),
      ),
    );
  }
}
