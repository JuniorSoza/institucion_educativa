import 'package:flutter/material.dart';
import 'package:institucioneducativa/screens/home.dart';
import 'package:institucioneducativa/screens/homePadre.dart';
import 'package:institucioneducativa/screens/login.dart';
import 'package:institucioneducativa/screens/materia.dart';
import 'package:institucioneducativa/screens/registrarUsuario.dart';
import 'package:institucioneducativa/screens/splash.dart';

const String splashPage = 'splash';
const String loginPage = 'login';
const String registrarUsuarioPage = 'registrarUsuario';
const String homePage = 'home';
const String homePadrePage = 'homePadre';
const String materiaPage = 'materia';


Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case splashPage:
      return MaterialPageRoute(builder: (context) => Splash());
    case loginPage:
      return MaterialPageRoute(builder: (context) => Login());
    case registrarUsuarioPage:
      return MaterialPageRoute(builder: (context) => RegistrarUsuario());
    case homePage:
      return MaterialPageRoute(builder: (context) => Home());
    case homePadrePage:
      return MaterialPageRoute(builder: (context) => HomePadre());
    case materiaPage:
      return MaterialPageRoute(builder: (context) => materia(settings.arguments));
    default:
      throw ('this route name does not exist');
  }
}


