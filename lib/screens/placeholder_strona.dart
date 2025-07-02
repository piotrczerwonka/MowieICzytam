import 'package:flutter/material.dart';

class PlaceholderStrona extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Placeholder')),
      body: Center(
        child: Text('Tu pojawi się nowe ćwiczenie', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
