import 'package:flutter/material.dart';
import 'cocktail.dart';
import 'cocktail_service.dart';

class CocktailDisplay extends StatelessWidget {
  final Future<List<String>> Function() fetchCocktails;
  const CocktailDisplay({Key? key, required this.fetchCocktails}) : super(key: key); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cocktails'),
      ),
      body: FutureBuilder<List<Cocktail>>(
        future: CocktailService().fetchCocktails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].category),
                  onTap: () {
                    _showDetails(context, snapshot.data![index]);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showDetails(BuildContext context, Cocktail cocktail) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(cocktail.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ID: ${cocktail.id}'),
              Text('Category: ${cocktail.category}'),
              Text('Glass Type: ${cocktail.glassType}'),
              Image.network(cocktail.imageUrl),
              Text('Ingredients: ${cocktail.ingredients.join(', ')}'),
              Text('Instructions: ${cocktail.instructions}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
