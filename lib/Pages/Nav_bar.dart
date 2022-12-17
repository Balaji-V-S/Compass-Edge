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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(1000)),
      ),
      child: Drawer(
        width: MediaQuery.of(context).size.width * 0.65, //<-- width controller
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
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        child: Image.asset('assets/new-logo.png'),
        padding: EdgeInsets.only(top: 10),
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
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('About us'),
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
              title: const Text('Rate Us'),
              onTap: () {},
            ),
            const Divider(
              color: Color.fromARGB(255, 15, 9, 9),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Exit'),
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
            const Text('Softrate India'),
            const Text('®All rights Reserved')
          ],
        ),
      );
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
                  Navigator.of(context).pop(true);
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
