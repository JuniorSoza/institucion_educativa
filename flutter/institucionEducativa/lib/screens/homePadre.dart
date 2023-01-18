import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../services/peticiones_service.dart';
import '../variables.dart';

class HomePadre extends StatefulWidget {
  const HomePadre({Key? key}) : super(key: key);

  @override
  State<HomePadre> createState() => _HomePadreState();
}

class _HomePadreState extends State<HomePadre> with SingleTickerProviderStateMixin {
  TabController ? controller;
  late Future myFuture;
  List _materias = [],_eventos = [];

  Future _dataInicial() async{
    var _respuesta, _respuestaEventos;
    try{
      final uri = Uri.parse(baseUrl+"institucionEducativa/getAlumnoMateria.php");
      final uriEventos = Uri.parse(baseUrl+"institucionEducativa/getEventos.php");
      final peticion = await http.post(uri,
          body:{'idUsuario': idUsuario}
      );
      final peticionEventos = await http.post(uriEventos,
          body:{'idUsuario': idUsuario}
      );
      _respuesta = jsonDecode(peticion.body);
      _respuestaEventos = jsonDecode(peticionEventos.body);
      if (_respuesta[0]['estado']) {
        _respuesta[0]['data'].toList().forEach((element) {
          _materias.add({
            'idMateria':element['idMateria'],
            'idAlumno':element['idAlumno'],
            'descripcionMateria': element['descripcionMateria'],
            'docenteMateria': element['docenteMateria'],
            'imgMateria': element['imgMateria'],
          });
        });
      }

      if (_respuestaEventos[0]['estado']) {
        _respuestaEventos[0]['data'].toList().forEach((element) {
          _eventos.add({
            'idEvento':element['idEvento'],
            'descripcionEvento':element['descripcionEvento'],
            'fechaEvento': element['fechaEvento'],
            'horaEvento': element['horaEvento'],
            'lugarEvento': element['lugarEvento'],
            'estadoEvento': element['estadoEvento'],
          });
        });
      }


    }catch(e){
      _respuesta = [{'estado':false,'mensaje':e.toString(),'data':[]}];
    }

    return(_materias);
  }

  @override
  void initState() {
    controller = TabController(length: 3,initialIndex: 0, vsync: this);
    myFuture = _dataInicial();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: myFuture,
          builder: (ctx, snp){
            if(snp.hasData){

              return Stack(
                children: <Widget>[
                  SafeArea(
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.orangeAccent
                            ),
                            child:TabBar(
                                controller: controller,
                                isScrollable: false,
                                indicator: BoxDecoration(color: Colors.black12),
                                tabs: const [
                                  Tab(text: 'Materias',icon: Icon(Icons.book)),
                                  Tab(text: 'Eventos',icon: Icon(Icons.event_available)),
                                  Tab(text: 'Configuraciones',icon: Icon(Icons.settings))
                                ]
                            ),
                          ),
                          Expanded(
                            child:TabBarView(
                                controller: controller,
                                children: [
                                  GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                    ),
                                    itemCount: _materias.toList().length,
                                    itemBuilder: (context, index) => GestureDetector(
                                      onTap: (){
                                        Navigator.of(context)
                                            .pushNamed(
                                            "materia",
                                            arguments: [
                                              {
                                                'idMateria': _materias[index]['idMateria'].toString(),
                                                'idAlumno': _materias[index]['idAlumno'].toString(),
                                                'descripcionMateria': _materias[index]['descripcionMateria'].toString(),
                                                'docenteMateria': _materias[index]['docenteMateria'].toString()
                                              }
                                            ]);
                                        //Navigator.of(context).pushNamed('materia');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                        child: Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(top:5,bottom: 10),
                                          height: 20,
                                          decoration: BoxDecoration (
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.black54,
                                                    blurRadius: 5
                                                )
                                              ]
                                          ),
                                          child: Stack(
                                            alignment: Alignment.bottomLeft,
                                            children: [
                                              ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child:SizedBox(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    child: SizedBox(
                                                      width: 100,
                                                      child: Image.memory(Base64Decoder().convert(_materias[index]['imgMateria'].toString())),
                                                    ),
                                                  )
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 30,
                                                padding: const EdgeInsets.only(top: 10,left: 10),
                                                decoration: const BoxDecoration(
                                                    color:Color.fromRGBO( 24, 138, 24,200),
                                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(_materias[index]['descripcionMateria'].toString(),//_respuesta![0]['data']['descripcionMateria'].toString(),
                                                      style: TextStyle(fontSize: 13,color: Colors.orangeAccent,fontWeight: FontWeight.bold),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: ListView.builder(
                                        itemCount: _eventos.toList().length,
                                        itemBuilder: (context, index){
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration (
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(10),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Colors.black54,
                                                        blurRadius: 5
                                                    )
                                                  ]
                                              ),
                                              padding: EdgeInsets.all(8),
                                              child: Column(
                                                children: [
                                                  Text(_eventos[index]['descripcionEvento'].toString(),style: TextStyle(fontSize: 20,color:Colors.orangeAccent),),
                                                  Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Row(
                                                      children: [
                                                        Text('Lugar del evento: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                                        Text(_eventos[index]['lugarEvento'].toString()),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Row(
                                                      children: [
                                                        Text('Fecha evento: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                                        Text(_eventos[index]['fechaEvento'].toString()+'  '+_eventos[index]['horaEvento'].toString()),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                          );
                                        }
                                    ),
                                    //child: Text('Eventos'),
                                  ),
                                  Container(
                                    child: Text('Configuraciones'),
                                  )
                                ]
                            ),
                          )
                        ],
                      )
                  ),
                ],
              );

            }else{
              return Center(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 250,
                    ),
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Cargando datos...')
                  ],
                ),
              );
            }
          }
      ),
    );
  }
}
