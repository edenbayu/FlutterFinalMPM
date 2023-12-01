class Cocktail {
  final String id;
  final String name;
  final String category;
  final String glassType;
  final String imageUrl;
  final List<String> ingredients;
  final String instructions;

  Cocktail({
    required this.id,
    required this.name,
    required this.category,
    required this.glassType,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
  });
}
