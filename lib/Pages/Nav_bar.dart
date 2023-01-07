import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:Compass_Edge/Pages/Home_screen.dart';
import 'package:Compass_Edge/Pages/mapbox.dart';
import 'package:Compass_Edge/Pages/Location_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter/services.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawer();
}

class _NavigationDrawer extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(1000)),
        ),
        child: Drawer(
          width:
              MediaQuery.of(context).size.width * 0.65, //<-- width controller
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildHeader(context),
                buildMenuItems(context),
                buildCompany(context),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () => _onBackpressed(context),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        child: Image.asset('assets/new-logo.png'),
        padding: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xded61557), Color(0xf03d4eaf)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        )),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(CupertinoIcons.group_solid),
              title: Text('About us',
                  style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold)),
              onTap: () async {
                var url = 'https://softrateindia.com/';

                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: true,
                    forceWebView: true,
                    enableJavaScript: true,
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: Text('Rate Us',
                  style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold)),
              onTap: () {},
            ),
            const Divider(
              color: Color.fromARGB(255, 15, 9, 9),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text(
                'Exit',
                style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold),
              ),
              onTap: () => _onBackpressed(context),
            ),
          ],
        ),
      );

  Widget buildCompany(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Image.asset(
              'assets/company-logo.png',
              height: 50,
              width: 120,
            ),
            Text('Softrate India',
                style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold)),
            Text('®All rights Reserved',
                style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold))
          ],
        ),
      );

  ////////////--------------------------Exit button Code-----------------/////////////
  Future<bool> _onBackpressed(BuildContext context) async {
    bool? exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Really?"),
            content: const Text("Do you want to exit the App?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  //Navigator.of(context).pop(true);
                  exit(0);
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("No"),
              )
            ],
          );
        });
    return exitApp ?? false;
  }
}
