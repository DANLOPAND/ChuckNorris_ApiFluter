import 'package:flutter/material.dart';
import 'package:poke_api/Widgets/DropDown.dart';
import 'package:poke_api/Widgets/FraseCard.dart';
import '../Models/Model_Chuck.dart';
import '../Provider/Chuck_Provider.dart';

class CategoriaFrases extends StatefulWidget {
  const CategoriaFrases({Key? key}) : super(key: key);

  @override
  State<CategoriaFrases> createState() => _CategoriaFrasesState();
}

class _CategoriaFrasesState extends State<CategoriaFrases> {
  late Future<List<ModelFrase>>
      _listadoFrases; //Variable que recibe una lista de frases
  late Future<List<ModelCategoria>>
      _categorias; //Variable que recibe una lista de categorias

  @override
  void initState() {
    _listadoFrases = FraseProvider().getFrases(); //Obtenemos las frases
    _categorias = FraseProvider().getCategorias(); //Obtenemos las categorias
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<List<ModelCategoria>>(
          future: _categorias,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DropDown(
                //Usamos el widget DropDown para mostrar las categorias y que tiene un metodo para cambiar la categoria
                cambiarCard: (String  x) {//al cambiar card le pasamos una funcion que recibe un string y para buscar una frase por la categoria que se selecciono
                  setState(() {
                    _listadoFrases = FraseProvider().getCategoriasFrase(
                        x); //Cambiamos la frase actual por uno de la categoria seleccionada
                  });
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(
              child: CircularProgressIndicator(), //Si no hay datos mostramos un circulo de carga
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ModelFrase>>(
              future: _listadoFrases,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return cardFrase(
                      snapshot.data?[0].value ?? "",
                      snapshot.data?[0].iconUrl ??
                          "assets/img/CN-00.jpg"); //Como simpre obtendremos un dato en la lista, seleccionamos el primer elemento. Y con ello creamos el card
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}"); //Si hay un error lo mostramos
                }
                return const Center(
                  child: CircularProgressIndicator(), //Mostramos un circulo de carga mientras se obtienen los datos
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
