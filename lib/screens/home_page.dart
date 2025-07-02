import 'package:flutter/material.dart';
import 'sylabizowanie/sylabizowanie_menu.dart';
import 'sylabizowanie/czytanie_strona.dart';
import 'placeholder_strona.dart';
import 'metronome.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wybierz ćwiczenie')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Czytanie par słów'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CzytanieStrona()),
              );
            },
          ),
          ListTile(
            title: Text('Grupa2'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlaceholderStrona()),
              );
            },
          ),
          ListTile(
            title: Text('Sylabizowanie'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SylabizowanieMenu()),
              );
            },
          ),ListTile(
            title: Text('Metronom'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MetronomeApp()),
              );
            },
          ),
        ],
      ),
    );
  }
}
