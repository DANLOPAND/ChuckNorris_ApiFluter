import 'package:flutter/material.dart';
import 'package:poke_api/Widgets/SearchBar.dart';
import 'package:poke_api/Widgets/FraseCard.dart';
import '../Models/Model_Chuck.dart';
import '../Provider/Chuck_Provider.dart';
import 'package:card_swiper/card_swiper.dart';

class InicioFrases extends StatefulWidget {
  const InicioFrases({Key? key}) : super(key: key);

  @override
  State<InicioFrases> createState() => _InicioFrasesState();
}

class _InicioFrasesState extends State<InicioFrases> {
  late Future<List<ModelFrase>> _listadoFrases;

  @override
  void initState() {
    _listadoFrases = FraseProvider().getFrases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, //Centramos el titulo
        title: searchBarFrase(context), //Usamos el widget searchBarFrase para que el usuario pueda buscar frases
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ModelFrase>>(
              future: _listadoFrases,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Swiper( //Usamos el widget Swiper para mostrar las frases
                    itemCount: snapshot.data!.length, //Cantidad de frases
                    itemWidth: 0.5, //Ancho de cada frase
                    onIndexChanged: (value) {
                      if (value == snapshot.data!.length - 8) { //Si el usuario llega al final de la lista de frases se cargan mas frases
                        final getprovider = FraseProvider();
                        getprovider.getFrases().then((value) {
                          setState(() {
                            _listadoFrases
                                .then((frases) => frases.addAll(value)); //Agregamos las nuevas frases a la lista de frases que ya teniamos y actualizamos el estado
                          });
                        });
                      }
                    },
                    itemBuilder: (context, index) => cardFrase(
                        snapshot.data![index].value, //Pasamos el texto de la frase al widget cardFrase
                        snapshot.data![index].iconUrl), //Pasamos la url de la imagen al widget cardFrase
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
