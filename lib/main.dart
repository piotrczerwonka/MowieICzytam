// main.dart
import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() => runApp(CzytanieApp());

class CzytanieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mówię i Czytam',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}