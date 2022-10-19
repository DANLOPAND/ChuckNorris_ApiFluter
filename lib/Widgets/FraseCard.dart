import 'Package:flutter/material.dart';

Widget cardFrase(String texto,  String img) { //Widget que muestra la frase y la imagen
  return Container(
    constraints: const BoxConstraints.expand(),
    margin: const EdgeInsets.only(left: 10, bottom: 10),
    child: Card( //Usamos un Card para mostrar la frase y la imagen
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10)),
      elevation: 10,
      child: Column(
        children: [
          Expanded( //Usamos un Expanded para que la imagen ocupe todo el espacio disponible
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  image: DecorationImage( //Usamos DecorationImage para mostrar la imagen
                    image: 
                      AssetImage(img), //Usamos la imagen que recibimos como parametro
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Expanded( //Se utiliza un Expanded para que el texto ocupe todo el espacio disponible
            flex: 3,
            child: Stack( //Usamos un Stack para mostrar el texto en la parte inferior del card
              children: [
                Row(children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(10),right: Radius.circular(10)))),
                  )
                ]),
                Center(
                  child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        texto, //Enviamos el texto que recibimos como parametro
                        textAlign: TextAlign.center,
                        style: TextStyle( 
                            fontFamily: "Anton",
                            fontStyle: FontStyle.normal,
                            fontSize:  (texto.length > 30) ? (50-(texto.length/7.5)) : 25, //El tamaño del texto depende de la longitud de la frase
                           //El tamaño de la letra depende de la longitud de la frase
                            color: Colors.white),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
