class IngredientNameModel {
  final String strIngredient;

  IngredientNameModel({required this.strIngredient});

  factory IngredientNameModel.fromJson(Map<String, dynamic> json) {
    return IngredientNameModel(
      strIngredient: json['strIngredient'],
    );
  }
}
