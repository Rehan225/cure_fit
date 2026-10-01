class Meal {
  final String id;
  final String name;
  final String category; // Breakfast, Lunch, Dinner, Snack
  final int price; // in rupees
  final int calories;
  final int protein; // in grams
  final int carbs; // in grams
  final int fat; // in grams
  final List<String> ingredients;
  final String description;
  final String imagePath;

  const Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.ingredients,
    required this.description,
    required this.imagePath,
  });
}
