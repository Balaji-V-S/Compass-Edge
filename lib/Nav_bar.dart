import 'package:Compass_Edge/Home_screen.dart';
import 'package:Compass_Edge/mapbox.dart';
import 'package:Compass_Edge/Location_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawer();
}

class _NavigationDrawer extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        color: Colors.red,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          runSpacing: 10,
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomeScreen(),
              )),
            ),
            ListTile(
              leading: const Icon(Icons.pin_drop),
              title: const Text('Location'),
              onTap: () {
                //close navbar before
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LocationState(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.flash_on_outlined),
              title: const Text('Map'),
              onTap: () {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MapScreen(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.flash_on_outlined),
              title: const Text('**Soon**'),
              onTap: () {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MapScreen(),
                ));
              },
            ),
            const Divider(
              color: Color.fromARGB(255, 15, 9, 9),
            ),
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
              onTap: () => SystemNavigator.pop(),
            ),
          ],
        ),
      );

  Widget buildCompany(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 160),
        child: Column(
          children: [
            Image.asset(
              'assets/company-logo.png',
              height: 50,
              width: 120,
            ),
            Text('Softrate India'),
            Text('®All rights Reserved')
          ],
        ),
      );
}
