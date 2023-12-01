import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocktail_app/cocktail_display.dart';

void main() {
  testWidgets('CocktailDisplay widget test', (WidgetTester tester) async {
    // Stub implementation for CocktailService
    Future<List<String>> fetchCocktails() async {
      // Simulate fetching cocktail data by returning mock data
      return Future.delayed(Duration.zero, () => ['Mocktail 1', 'Mocktail 2']);
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: CocktailDisplay(fetchCocktails: fetchCocktails), // Pass the stub function using named parameter
    ));

    // Expect CircularProgressIndicator while data is loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the data to load
    await tester.pump();

    // Expect the list of cocktails to be displayed
    expect(find.text('Mocktail 1'), findsOneWidget);
    expect(find.text('Mocktail 2'), findsOneWidget);
  });
}
