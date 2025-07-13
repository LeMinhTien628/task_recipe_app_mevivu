class RecipeModel {
  final String imagePath;
  final String title;
  final String time;
  final String author;
  final String avatarPath;
  final double rating;
  final bool isFavorite;
  final String? idMeal;
  final String? instructions;
  final String? category;
  final String? area;
  final String? youtubeUrl;
  final String? tags;
  final String? thumb;
  final List<String>? ingredients;
  final List<String>? measures;

  RecipeModel({
    required this.imagePath,
    required this.title,
    required this.time,
    required this.author,
    required this.avatarPath,
    required this.rating,
    this.isFavorite = false,
    this.idMeal,
    this.instructions,
    this.category,
    this.area,
    this.youtubeUrl,
    this.tags,
    this.thumb,
    this.ingredients,
    this.measures,
  });

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'title': title,
      'time': time,
      'author': author,
      'avatarPath': avatarPath,
      'rating': rating,
      'isFavorite': isFavorite,
      'idMeal': idMeal,
      'instructions': instructions,
      'category': category,
      'area': area,
      'youtubeUrl': youtubeUrl,
      'tags': tags,
      'thumb': thumb,
      'ingredients': ingredients,
      'measures': measures,
    };
  }

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    List<String> ingredientsList = [];
    List<String> measuresList = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredientsList.add(ingredient.toString().trim());
        measuresList.add((measure ?? '').toString().trim());
      }
    }

    return RecipeModel(
      imagePath: json['imagePath'] ?? json['strMealThumb'] ?? '',
      title: json['title'] ?? json['strMeal'] ?? '',
      time: json['time'] ?? '30 phút',
      author: json['author'] ?? json['strArea'] ?? 'Ẩn danh',
      avatarPath: json['avatarPath'] ?? 'assets/images/user.png',
      rating: (json['rating'] ?? 4.5).toDouble(),
      isFavorite: json['isFavorite'] ?? false,
      idMeal: json['idMeal'],
      instructions: json['strInstructions'],
      category: json['strCategory'],
      area: json['strArea'],
      youtubeUrl: json['strYoutube'],
      tags: json['strTags'],
      thumb: json['strMealThumb'],
      ingredients: ingredientsList,
      measures: measuresList,
    );
  }

  RecipeModel copyWith({
    String? imagePath,
    String? title,
    String? time,
    String? author,
    String? avatarPath,
    double? rating,
    bool? isFavorite,
    String? idMeal,
    String? instructions,
    String? category,
    String? area,
    String? youtubeUrl,
    String? tags,
    String? thumb,
    List<String>? ingredients,
    List<String>? measures,
  }) {
    return RecipeModel(
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      time: time ?? this.time,
      author: author ?? this.author,
      avatarPath: avatarPath ?? this.avatarPath,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
      idMeal: idMeal ?? this.idMeal,
      instructions: instructions ?? this.instructions,
      category: category ?? this.category,
      area: area ?? this.area,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      tags: tags ?? this.tags,
      thumb: thumb ?? this.thumb,
      ingredients: ingredients ?? this.ingredients,
      measures: measures ?? this.measures,
    );
  }
}
