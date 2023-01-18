import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../services/peticiones_service.dart';

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=>_Home();

}

class _Home extends State<Home> with SingleTickerProviderStateMixin{
  TabController ? controller;
  late Future myFuture;
  List _materias = [];
  late final PlutoGridStateManager stateManager;
  List _datos = [];

  Future _dataInicial() async{
    var _respuesta;
    _respuesta =  await peticionesService().peticionGet("institucionEducativa/getMaterias.php",{'accion': 'GET'});

    if (_respuesta[0]['estado']) {
      _respuesta[0]['data'].toList().forEach((element) {
        _materias.add({
          'descripcionMateria': element['descripcionMateria'],
          'docenteMateria': element['docenteMateria'],
          'imgMateria': element['imgMateria'],
        });
      });
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
                                    Navigator.of(context).pushNamed('materia');
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
                                                  style: TextStyle(fontSize: 13,color: const Color.fromRGBO( 24, 138, 24,10),fontWeight: FontWeight.bold),
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
                                width: MediaQuery.of(context).size.width*0.9,
                                height: MediaQuery.of(context).size.height*0.8,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: PlutoGrid(
                                    columns: columns,
                                    rows: rowsLista(_datos),//_respuesta[0]['data']),//rows,
                                    onLoaded: (PlutoGridOnLoadedEvent event) {
                                      stateManager = event.stateManager;
                                      event.stateManager.setShowColumnFilter(true);
                                    },
                                    onRowDoubleTap:(PlutoGridOnRowDoubleTapEvent event) async {

                                    },
                                    onChanged: (PlutoGridOnChangedEvent event) {
                                      //_generarPdf(event.oldValue);
                                    },
                                    //columnGroups: columnGroups,
                                    configuration: const PlutoGridConfiguration(
                                      enableColumnBorder: true,
                                    ),
                                    createFooter: (stateManager) {
                                      stateManager.setPageSize(15, notify: false); // default 40
                                      return PlutoPagination(stateManager);
                                    }
                                ),
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

  List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Eliminar',
      field: 'Eliminar',
      type: PlutoColumnType.text(),
      width: 100,
      minWidth: 175,
      renderer: (rendererContext) {
        return Row(
          children: [
            IconButton(
              icon:  const Icon(
                Icons.delete_forever,
              ),
              onPressed: () {
              },
              iconSize: 18,
              color: Colors.red,
              padding: const EdgeInsets.all(0),
            ),
          ],
        );
      },
    ),
    PlutoColumn(
      title: 'Username',
      field: 'username',
      //readOnly: true,
      type: PlutoColumnType.text(),
    ),
  ];

  List<PlutoRow> rowsLista(List info) {
    List<PlutoRow> _return = [];
    for (var _rowInfo in info) {
      _return.add(PlutoRow(
        cells: {
          'Eliminar': PlutoCell(value: _rowInfo['id']),
          'username': PlutoCell(value: _rowInfo['username'])
        },
      ));
    }
    return _return;
  }
}
