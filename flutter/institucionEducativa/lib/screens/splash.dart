import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import '../services/peticiones_service.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Lottie.asset('assets/62404-academic-hut-banner.json',),
              ),
              flex: 55,
            ),
            const Expanded(
              child:  Text('.:Institución Educativa:.',style:TextStyle(color: Colors.blueGrey, fontSize: 25, fontWeight: FontWeight.bold),),
              flex: 5,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5, vertical: 2),
                child: ElevatedButton.icon(
                  label: const Text('Bienvenidos, iniciar...'),
                  icon: const Icon(Icons.play_circle_fill_sharp),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal:50)
                      )
                  ),
                  onPressed: ()  async {
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                ),
              ),
              flex: 5,
            ),
            Expanded(
              flex: 5,
              child: Text(''),
            )
          ],
        ),
      ),
    );
  }
}
