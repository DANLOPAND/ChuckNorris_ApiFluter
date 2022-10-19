import 'dart:math';

import 'package:poke_api/Provider/Chuck_Provider.dart';

FraseProvider fraseProvider = FraseProvider();

class Frase {
  List<ModelFrase> items = [];

  Frase();

  Frase.fromJsonList(jsonList) {
    for (var item in jsonList) {
      final frase = ModelFrase.fromJsonMap(item);
      items.add(frase);
    }
  }
}

class ModelFrase {
  ModelFrase({
    required this.categories,
    required this.createdAt,
    required this.iconUrl,
    required this.id,
    required this.updatedAt,
    required this.url,
    required this.value,
  });

  List<ModelCategoria> categories;
  DateTime createdAt;
  String iconUrl;
  String id;
  DateTime updatedAt;
  String url;
  String value;

  factory ModelFrase.fromJsonMap(Map<String, dynamic> json) => ModelFrase(
        categories: List<ModelCategoria>.from(json["categories"].map(
            (x) => x.toString())), //Usamos List.from para convertir el json en una lista
        createdAt: DateTime.parse(json[
            "created_at"]), //Usamos DateTime.parse para convertir el json en un DateTime
        iconUrl:
            getImagen(), //Usamos getImagen para obtener una imagen aleatoria
        id: json["id"],
        updatedAt: DateTime.parse(json[
            "updated_at"]), //usamos DateTime.parse para convertir el json en un DateTime
        url: json["url"],
        value: json["value"],
      );
}

class Categoria {
  List<ModelCategoria> items = [];

  Categoria();

  Categoria.fromJsonList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      final frase = ModelCategoria.fromJsonMap(item);
      items.add(frase);
    }
  }
}

class ModelCategoria {
  ModelCategoria({
    required this.nombre,
  });

  String nombre;

  factory ModelCategoria.fromJsonMap(String data) => ModelCategoria(
          nombre: data); //Usamos toString para convertir el json en un String
}

getImagen() {
  //Funcion para obtener una imagen aleatoria
  Random random = Random(); //Instanciamos la clase Random
  int numero = random.nextInt(9); //Generamos un numero aleatorio entre 0 y 6
  return "assets/img/CN-0$numero.jpg"; //Retornamos un string con la ruta de la imagen aleatoria
}
