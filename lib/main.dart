import 'welcome.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'ProyectoCoffeeCoding',
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}
