import 'package:flutter/material.dart';
import 'option_selector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blue Rose Character Creator',
      theme: ThemeData(
        cardTheme: const CardTheme(margin: EdgeInsets.all(8)),
        primaryColor: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        cardTheme: const CardTheme(margin: EdgeInsets.all(8)),
        primaryColor: Colors.blue[200],
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Blue Rose Character Creator')),
        body: CharacterOptionSelector(),
      ),
    );
  }
}
