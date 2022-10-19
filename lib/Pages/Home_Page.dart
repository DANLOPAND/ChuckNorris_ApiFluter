import 'package:flutter/material.dart';
import 'package:poke_api/Widgets/CategoriaFrase.dart';
import 'package:poke_api/Widgets/PageInicio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    //Lista de widgets que se mostraran en el body
    const InicioFrases(), //Pantalla principal

    const CategoriaFrases(), //Pantalla de categorias
  ];

  void _onItemTapped(int index) {
    //Funcion que se ejecuta cuando se presiona un item del BottomNavigationBar
    setState(() {
      _selectedIndex = index; //variable que controla el index del BottomNavigationBar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(//
        items: const <BottomNavigationBarItem>[ //Lista de items que se mostraran en el BottomNavigationBar
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categoria',
          ),
        ],
        currentIndex: _selectedIndex, //Index que se mostrara en el BottomNavigationBar
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
