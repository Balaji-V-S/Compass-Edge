import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class TorchButton extends StatefulWidget {
  const TorchButton({Key? key}) : super(key: key);

  @override
  State<TorchButton> createState() => _TorchButtonState();
}

class _TorchButtonState extends State<TorchButton> {
  bool hasflashlight = true; //to set is there any flashlight ?
  bool isturnon = false; //to set if flash light is on or off
  IconData flashicon = Icons.flashlight_on_sharp; //icon for lashlight button

  void torchLightOff() async {
    try {
      await TorchLight.disableTorch();
    } catch (e) {
      print(e);
    }
  }

  void torchLightOn() async {
    try {
      await TorchLight.enableTorch();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      //we use Future.delayed because there is async function inside it.
      bool istherelight = true;
      setState(() {
        hasflashlight = istherelight;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (isturnon) {
            //if light is on, then turn off
            torchLightOn();
            setState(() {
              isturnon = false;
              flashicon = Icons.flashlight_off_sharp;
            });
          } else {
            //if light is off, then turn on.
            torchLightOff();
            setState(() {
              isturnon = true;
              flashicon = Icons.flashlight_on_sharp;
            });
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 465),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black26,
                      offset: const Offset(
                        10.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [Color(0xff673ab7), Color(0xe6f44336)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
              child: const Icon(Icons.flashlight_on_sharp),
            ),
          ),
        ),
      ),
    );
  }
}
