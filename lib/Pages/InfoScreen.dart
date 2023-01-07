import 'package:flutter/material.dart';
import 'package:compass_edge/Pages/Nav_bar.dart';
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
                child: Text('Information',
                    style: GoogleFonts.jost(
                        fontSize: 20, fontWeight: FontWeight.bold)))
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
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/security.png',
                    width: 300,
                  )),
            ),
            const SizedBox(height: 15),
            Text(
              'Are you concerned about data security?',
              style: GoogleFonts.jost(),
            ),
            const SizedBox(height: 10),
            Text(
              "Relax! It's Softrate, and we won't gather any user data.",
              style: GoogleFonts.jost(),
            ),
            const SizedBox(height: 30),
            Text(
              'We Keep Your Information \nPrivate, Safe and \nSecured',
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.jost(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Softrate respects and protects your privacy through \n industry-leading security infrastructure, responsible \n data practises, and simple privacy tools \n that put you in control.',
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(fontSize: 15),
            ),
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
