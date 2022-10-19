import 'package:flutter/material.dart';
import 'package:poke_api/Models/Model_Chuck.dart';
import 'package:poke_api/Provider/Chuck_Provider.dart';

class DropDown extends StatefulWidget {
  final void Function(String) cambiarCard; //Funcion para cambiar el card
  const DropDown({Key? key, required this.cambiarCard}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
    late Future<List<ModelCategoria>> _categorias; //Variable que recibe una lista de categorias

    @override
  void initState() {
    _categorias = FraseProvider().getCategorias(); //Obtenemos las categorias
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModelCategoria>>( 
          future: _categorias,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DropdownButtonFormField( //Usamos el widget DropDown para mostrar las categorias y que tiene un metodo para cambiar la categoria
                itemHeight: 56,items: snapshot.data?.map<DropdownMenuItem<ModelCategoria>>((ModelCategoria value) {  //Mapeamos los datos para que se muestren en el dropdown
                  return DropdownMenuItem( //Retornamos un dropdownMenuItem
                    value: value, //Valor que se va a mostrar
                    child: Text(value.nombre), //Nombre que se va a mostrar
                  );
                }).toList(), onChanged: (ModelCategoria? x) {setState(() { //al cambiar el item se llama la funcion onChange la cual ejecuta la funcion cambiarCard que recibe un string y actualiza el card
                      widget.cambiarCard(x!.nombre);
                });});
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
    
  }
}