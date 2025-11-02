import 'package:flutter/material.dart';
import 'package:adidu_shop/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adidu Football Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)
          .copyWith(
            primary: Colors.teal,
            secondary: Colors.blueAccent,
          ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}