import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/Model_Chuck.dart';

class FraseProvider {
  Future<List<ModelFrase>> getFrases() async {
    List listaFrases = [];
    String Url = "https://api.chucknorris.io/jokes/random";
    for (var i = 0; i < 10; i++) { //Hacemos un for para que nos traiga 10 frases
      listaFrases.add(await Request(Url)); //Agregamos la frase a la lista
    }
    final frases = Frase.fromJsonList(
        listaFrases); //Instanciamos la clase Frase y le pasamos la lista de frases
    return frases.items; //Retornamos la lista de frases
  }

  Future<List<ModelFrase>> getQuery(String query) async {
    //Url de la API que busca una frase por query
    String Url = "https://api.chucknorris.io/jokes/search?query=$query";
    final json = await Request(Url);
    if (json["total"] == 0) {
      return [];
    } else {
      List listaFrases = json["result"];
      if (listaFrases.length > 20) { //Si el tamaño de la lista es mayor a 20, solo mostramos 20 frases si 
        listaFrases = listaFrases.sublist(0, 20);
      }
      final frases = Frase.fromJsonList(
          listaFrases); //Instanciamos la clase Frase y le pasamos la lista de frases
      return frases.items; //Retornamos la lista de frases
    }
  }

  Future<List<ModelCategoria>> getCategorias() async {
    //Url de la API que busca una frase por query
    String Url = "https://api.chucknorris.io/jokes/categories";

    final categorias = Categoria.fromJsonList(await Request(Url));
    return categorias.items; //Retornamos la lista de frases
  }

  Future<List<ModelFrase>> getCategoriasFrase(String categoria) async {
    //Url de la API que busca una frase por query
    String Url = "https://api.chucknorris.io/jokes/random?category=$categoria";
    final categorias = Frase.fromJsonList([await Request(Url)]);
    return categorias.items; //Retornamos la lista de frases
  }

  dynamic Request(Url) async {
    final response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);
      if (json.isEmpty) { //Si la respuesta esta vacia retornamos un mensaje de error
        return [];
      } else {
        return json; //Retornamos un json con toda la informacion del endpoint 
      }
    } else {
      throw "Fallo al buscar la frase";
    }
  }
}
