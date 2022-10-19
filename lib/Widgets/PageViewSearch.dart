import 'package:flutter/material.dart';
import 'package:poke_api/Widgets/FraseCard.dart';

import '../Models/Model_Chuck.dart';
import '../Provider/Chuck_Provider.dart';

class PageViewFrases extends StatefulWidget {
  final String query; //Variable que recibe el texto de la busqueda
  const PageViewFrases({Key? key, required this.query}) : super(key: key);

  @override
  State<PageViewFrases> createState() => _PageViewFrasesState();
}

class _PageViewFrasesState extends State<PageViewFrases> {
  late Future<List<ModelFrase>> _listadoGifs;

  @override
  void initState() {
    super.initState();
    _listadoGifs = FraseProvider().getQuery(widget.query); //Obtenemos las frases por el texto que se encuentra en la variable query
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded( //Usamos un Expanded para que el widget se adapte al tamaño de la pantalla
          flex: 1,
          child: FutureBuilder<List<ModelFrase>>(
            future: _listadoGifs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PageView(
                    padEnds: false,
                    scrollDirection: Axis.vertical,
                    controller: PageController(initialPage: 0),
                    children: listaFrases(snapshot.data!)); //Con un future builder obtenemos la lista de frases y la pasamos al widget PageView
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}", style: const TextStyle(fontSize: 30)));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}

List<Widget> listaFrases(List<ModelFrase> listado) {
  //Funcion para crear una lista de widgets a partir de una lista de ModelFrase
  final List<Widget> listaFrases = [];
  for (var element in listado) {
    listaFrases.add(
      cardFrase(element.value, element.iconUrl), //Aqui se crea el widget Card y se agrega a la lista
    );
  }
  if (listado.isEmpty) {
    return [
      const Center(
        child: Text("No hay resultados", style: TextStyle(fontSize: 30)), //Si no hay resultados mostramos un texto de no hay resultados
      )
    ];
  } else {
    return listaFrases;
  }
}
