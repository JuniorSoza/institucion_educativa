import 'package:flutter/material.dart';

class materia extends StatefulWidget {
  final parametros;
  materia(this.parametros);

  @override
  State<materia> createState() => _materiaState(this.parametros);
}

class _materiaState extends State<materia> {

  final  parametros;
  _materiaState(this.parametros);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Materia'),
          backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(child: Text(parametros[0]['descripcionMateria'],style: TextStyle(fontSize: 20,color:Colors.orangeAccent),)),
                      Text(parametros[0]['docenteMateria'])
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text('Calificaciones'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
