import 'package:flutter/material.dart';
import 'package:poke_api/Widgets/PageViewSearch.dart';

Widget searchBarFrase(context) {
  TextEditingController controller =
      TextEditingController(); //Controlador del TextField
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 40), //Padding del TextField
    child: TextField(
      controller: controller, //Le asignamos el controlador al TextField
      onEditingComplete: () {//Se ejecuta cuando se presiona el boton de buscar en el teclado
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SubScreen(controller.value.text); //Enviamos el texto del TextField a la siguiente pantalla
        }));
      },
      decoration: const InputDecoration(
        hintText: 'Buscar', //Texto de ayuda
        hintStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    ),
  );
}

class SubScreen extends StatelessWidget { //Pantalla que muestra el resultado de la busqueda
  final String textoBuscar; //Variable que recibe el texto del TextField
  const SubScreen(
    this.textoBuscar, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // just simulating different number of children
    return Scaffold(
      appBar: AppBar(title: Text(textoBuscar)),
      body: PageViewFrases( //Usamos el widget personalizado para mostrar las frases
        query: textoBuscar, //Enviamos el texto del TextField al widget personalizado
      ),
    );
  }
}
