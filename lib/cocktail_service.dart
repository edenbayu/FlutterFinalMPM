import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'cocktail.dart';


class CocktailService {
  final String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';

  Future<List<Cocktail>> fetchCocktails() async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=margarita'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Map<String, dynamic>> cocktailsData = List.from(jsonData['drinks']);

      return cocktailsData.map((cocktailData) {
        return Cocktail(
          id: cocktailData['idDrink'],
          name: cocktailData['strDrink'],
          category: cocktailData['strCategory'],
          glassType: cocktailData['strGlass'],
          imageUrl: cocktailData['strDrinkThumb'],
          ingredients: _extractIngredients(cocktailData),
          instructions: cocktailData['strInstructions'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  List<String> _extractIngredients(Map<String, dynamic> cocktailData) {
    final ingredients = <String>[];
    for (int i = 1; i <= 15; i++) {
      final ingredient = cocktailData['strIngredient$i'];
      final measure = cocktailData['strMeasure$i'];

      if (ingredient != null && ingredient.isNotEmpty && measure != null && measure.isNotEmpty) {
        ingredients.add('$ingredient: $measure');
      } else if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(ingredient);
      } else if (measure != null && measure.isNotEmpty) {
        ingredients.add(measure);
      }
    }
    return ingredients;
  }
}

class NetworkService {
  final HttpClient _httpClient;

  NetworkService(this._httpClient);

  Future<String> fetchData(String url) async {
    final request = await _httpClient.getUrl(Uri.parse(url));
    final response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      return await response.transform(utf8.decoder).join();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}