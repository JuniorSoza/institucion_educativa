import 'package:flutter/material.dart';
import 'package:institucioneducativa/screens/routingProjectSettings.dart' as route;

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp>{


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Institucion educativa',
      onGenerateRoute: route.controller,
      initialRoute: route.loginPage,
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        primaryColorDark: Colors.blueGrey,
      ),
    );

  }

}
