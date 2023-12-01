import 'package:flutter/material.dart';
import 'package:cocktail_app/cocktail_display.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cocktail App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CocktailDisplay(
        fetchCocktails: () {
          // Simulate fetching cocktail data by returning mock data
          return Future.delayed(Duration.zero, () => ['Mocktail 1', 'Mocktail 2']);
        },
      ),
    );
  }
}
