import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:institucioneducativa/widgets/input.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

import '../variables.dart';

class RegistrarUsuario extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegistrarUsuario();
}

class _RegistrarUsuario extends State<RegistrarUsuario>{

  final _usuario = TextEditingController();
  final _clave = TextEditingController();
  final _nombreUsuario = TextEditingController();
  final _apellidoUsuario = TextEditingController();
  final _cedulaUsuario = TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;
  String _mensajeLogeo = '';
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          //color: Colors.grey[350],
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: kIsWeb ? MediaQuery.of(context).size.height * 0.1 : MediaQuery.of(context).size.height * 0.1,
                              horizontal: kIsWeb ? MediaQuery.of(context).size.height * 0.2 : MediaQuery.of(context).size.height * 0.05),
                          child: ResponsiveGridRow(
                            children: [
                              ResponsiveGridCol(
                                  xl: 4,
                                  md: 3,
                                  lg: 3,
                                  sm: 0,
                                  xs: 0,
                                  child: Container(
                                  )
                              ),
                              ResponsiveGridCol(
                                  xl: 4,
                                  md: 6,
                                  lg: 6,
                                  sm: 12,
                                  xs: 12,
                                  child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(20),
                                      //margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))
                                          ]),

                                      child: Form(
                                          key: _formKey,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Lottie.asset('assets/38435-register.json'),
                                                ),
                                                TextFormField(
                                                  controller: _nombreUsuario ,
                                                  autocorrect: false,
                                                  keyboardType: TextInputType.text,
                                                  decoration: Input.authInput(
                                                      hintTex: 'Nombres',
                                                      labelText: 'Nombres',
                                                      prefixIcon: Icons.list),
                                                  onChanged: (value){
                                                    setState(() {
                                                      _mensajeLogeo = '';
                                                    });
                                                  },
                                                  validator: (value) {
                                                    return (value != null &&
                                                        value.length >= 5)
                                                        ? null
                                                        : 'los nombres deben ser de mas de 10 caracteres';
                                                  },
                                                ),
                                                TextFormField(
                                                  controller: _apellidoUsuario ,
                                                  autocorrect: false,
                                                  keyboardType: TextInputType.text,
                                                  decoration: Input.authInput(
                                                      hintTex: 'Apellidos',
                                                      labelText: 'Apellidos',
                                                      prefixIcon: Icons.list),
                                                  onChanged: (value){
                                                    setState(() {
                                                      _mensajeLogeo = '';
                                                    });
                                                  },
                                                  validator: (value) {
                                                    return (value != null &&
                                                        value.length >= 5)
                                                        ? null
                                                        : 'Los apellidos deben ser de mas de 10 caracteres';
                                                  },
                                                ),
                                                TextFormField(
                                                  controller: _cedulaUsuario,
                                                  autocorrect: false,
                                                  maxLength: 10,
                                                  keyboardType: TextInputType.text,
                                                  decoration: Input.authInput(
                                                      hintTex: 'Cedula',
                                                      labelText: 'Cedula',
                                                      prefixIcon: Icons.numbers),
                                                  onChanged: (value){
                                                    setState(() {
                                                      _mensajeLogeo = '';
                                                    });
                                                  },
                                                  validator: (value) {
                                                    return (value != null &&
                                                        value.length >= 5)
                                                        ? null
                                                        : 'La cédula debe tener 10 caracteres';
                                                  },
                                                ),
                                                TextFormField(
                                                  controller: _usuario ,
                                                  autocorrect: false,
                                                  keyboardType: TextInputType.text,
                                                  decoration: Input.authInput(
                                                      hintTex: 'usuario',
                                                      labelText: 'Usuario',
                                                      prefixIcon: Icons.person),
                                                  onChanged: (value){
                                                    setState(() {
                                                      _mensajeLogeo = '';
                                                    });
                                                  },
                                                  validator: (value) {
                                                    return (value != null &&
                                                        value.length >= 5)
                                                        ? null
                                                        : 'El usuario debe ser de mas de 5 caracteres';
                                                  },
                                                ),
                                                TextFormField(
                                                  controller: _clave,
                                                  autocorrect: false,
                                                  obscureText: _isObscure,
                                                  keyboardType: TextInputType.text,
                                                  onFieldSubmitted: (value) async{
                                                    //await _logear();
                                                  },
                                                  decoration: InputDecoration(
                                                    enabledBorder: const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:Colors.orangeAccent)),
                                                    focusedBorder: const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 2)),
                                                    hintText: '******',
                                                    labelText: 'Clave',
                                                    labelStyle: const TextStyle(
                                                        color: Colors.grey),
                                                    prefixIcon: const Icon(Icons.lock,),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                          _isObscure ? Icons.visibility : Icons.visibility_off,  //Icons.remove_red_eye_outlined,
                                                          color: Colors.black),
                                                      onPressed: () {
                                                        setState(() {
                                                          _isObscure = !_isObscure;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  onChanged: (value){
                                                    setState(() {
                                                      _mensajeLogeo = '';
                                                    });
                                                  },
                                                  validator: (value) {
                                                    return (value != null &&
                                                        value.length >= 4)
                                                        ? null
                                                        : 'La clave debe ser de más de 5 caracteres';
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                MaterialButton(
                                                    disabledColor: Colors.grey,
                                                    elevation: 0,
                                                    color: Colors.orangeAccent,
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                      child: Text(
                                                        _isLoading
                                                            ? 'Registrando...'
                                                            : 'Registrar',
                                                        style: const TextStyle(
                                                            color: Colors.white),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                    onPressed: _isLoading
                                                        ? null
                                                        :() async {
                                                      if (!_formKey.currentState!.validate()) return;
                                                      await _registrando();
                                                    }),
                                                Text(_mensajeLogeo,style:const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                                              ]
                                          )
                                      )
                                  )
                              )
                            ],
                          )
                      ),
                    ]
                )
            )
        ),
      ),
    );
  }

  Future _registrar(String nombreUsuario, String apellidoUsuario, String cedulaUsuario, String usuarioCredencial, String claveCredencial, String rolUsuario) async{
    var _respuesta;
    try{
      final uri = Uri.parse(baseUrl+"institucionEducativa/addUsuario.php");
      final peticion = await http.post(uri,
          body:{'nombreUsuario': nombreUsuario
                ,'apellidoUsuario':apellidoUsuario
                ,'cedulaUsuario':cedulaUsuario
                ,'usuarioCredencial':usuarioCredencial
                ,'claveCredencial':claveCredencial
                ,'rolUsuario':rolUsuario
          }
      );
      _respuesta = jsonDecode(peticion.body);
    }catch(e){
      _respuesta = [{'estado':false,'mensaje':e.toString(),'data':[]}];
    }
    print(_respuesta);
    return(_respuesta);
  }

  _registrando() async {
    try{
      var _respuesta = await _registrar(_nombreUsuario.text,_apellidoUsuario.text,_cedulaUsuario.text,_usuario.text,_clave.text,'PADRE');
      if(_respuesta[0]['estado']){
        _mensajeLogeo =  _respuesta[0]['mensaje'];
        _limpiarCampos();
      }else{
        _mensajeLogeo =  _respuesta[0]['mensaje'];
      }
    }catch(e){
      _mensajeLogeo = e.toString();
    }
    setState(() {});
  }

  _limpiarCampos(){
    _nombreUsuario.text = '';
    _apellidoUsuario.text = '';
    _cedulaUsuario.text = '';
    _usuario.text = '';
    _clave.text = '';
    setState(() {});
  }
}
