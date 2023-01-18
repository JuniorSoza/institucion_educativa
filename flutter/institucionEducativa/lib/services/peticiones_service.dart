import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../variables.dart';

class peticionesService extends ChangeNotifier{
  List _Respuesta = [];
  Future peticionPost(String _UrlPeticion, Map<String,dynamic>? _Parametros) async {


    return _Respuesta;
  }

  Future peticionGet(String _UrlPeticion,Map<String,dynamic>? _Parametros) async {
    try{
      final uri = Uri.parse(baseUrl + _UrlPeticion).replace(queryParameters: _Parametros);
      final headers = {"Access-Control-Allow-Origin": "*"};
      final peticion = await http.get(
          uri,
          headers: headers
      );
      _Respuesta = jsonDecode(peticion.body);
    }catch(e){
      _Respuesta = [{'estado':false,'mensaje':e.toString()}];
    }
    return _Respuesta;
  }

}