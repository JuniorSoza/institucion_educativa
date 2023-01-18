import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:institucioneducativa/widgets/input.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../variables.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {

  final _usuario = TextEditingController();
  final _clave = TextEditingController();
  bool _isObscure = true;
  bool _isLoading = false;
  String _mensajeLogeo = '';
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


  Future _logear(String usuarioCredencial, String claveCredencial) async{
    var _respuesta;
    try{
      final uri = Uri.parse(baseUrl+"institucionEducativa/login.php");
      final peticion = await http.post(uri,
        body:{'usuarioCredencial': usuarioCredencial,'claveCredencial':claveCredencial}
      );
      _respuesta = jsonDecode(peticion.body);
    }catch(e){
      _respuesta = [{'estado':false,'mensaje':e.toString(),'data':[]}];
    }
    return(_respuesta);
  }

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
                                                  child: Lottie.asset('assets/72874-user-profile-v2.json'),
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
                                                    await _login();
                                                  },
                                                  decoration: InputDecoration(
                                                    enabledBorder: const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.orangeAccent)),
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
                                                            ? 'Validando'
                                                            : 'Ingresar',
                                                        style: const TextStyle(
                                                            color: Colors.white),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                    onPressed: _isLoading
                                                        ? null
                                                        :() async {
                                                      await _login();
                                                    }),
                                                Text(_mensajeLogeo,style:const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    textStyle: const TextStyle(fontSize: 14,color: Colors.orangeAccent),
                                                  ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed('registrarUsuario');
                                                    },
                                                    child: const Text('<- Nueva cuenta ->'),
                                                ),
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

  _login() async {
    try{
      if(!_formKey.currentState!.validate()) return;
      var _respuesta = await _logear(_usuario.text,_clave.text);
      if(_respuesta[0]['estado']){
        idUsuario = _respuesta[0]['data']['idUsuario'];
        if(_respuesta[0]['data']['rolUsuario']=='PADRE'){
          Navigator.pushReplacementNamed(context, 'homePadre');
        }else{
          Navigator.pushReplacementNamed(context, 'home');
        }
      }else{
        _mensajeLogeo =  _respuesta[0]['mensaje'];
      }
    }catch(e){
      _mensajeLogeo = e.toString();
    }
    setState(() {});
  }
}
