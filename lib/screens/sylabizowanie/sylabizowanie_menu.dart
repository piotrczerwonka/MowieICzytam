import 'package:flutter/material.dart';
import 'czytanie_slow.dart';
import 'czytanie_strona.dart';

class SylabizowanieMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ćwiczenia: Sylabizowanie')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Ćwiczenie 1: Czytanie słów'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CzytanieSlow2()),
              );
            },
          ), ListTile(
            title: Text('Ćwiczenie 2: Czytanie słów (placeholder)'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CzytanieStrona()),
              );
            },
          ),
          // Możesz dodać więcej ListTile dla kolejnych ćwiczeń
        ],
      ),
    );
  }
}
