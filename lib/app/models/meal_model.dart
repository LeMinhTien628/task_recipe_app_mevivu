class MealModel {
  // Mã định danh món ăn duy nhất (VD: "52771")
  final String idMeal;

  // Tên món ăn (VD: "Spicy Arrabiata Penne")
  final String strMeal;

  // Tên thay thế của món (có thể null, ít khi dùng)
  final String? strMealAlternate;

  // Danh mục món ăn (VD: "Vegetarian", "Seafood", "Beef"...)
  final String strCategory;

  // Khu vực hoặc quốc gia món ăn xuất xứ (VD: "Italian", "Mexican"...)
  final String strArea;

  // Hướng dẫn chi tiết cách nấu món ăn (định dạng văn bản dài)
  final String strInstructions;

  // URL ảnh đại diện món ăn
  final String strMealThumb;

  // Các từ khóa liên quan (tags), ngăn cách bằng dấu phẩy (VD: "Pasta,Curry")
  final String? strTags;

  // Đường dẫn video YouTube hướng dẫn nấu món ăn
  final String? strYoutube;

  // Danh sách các nguyên liệu của món ăn (VD: ["penne rigate", "garlic", "basil",...])
  final List<String> ingredients;

  // Danh sách định lượng tương ứng với từng nguyên liệu (VD: ["1 pound", "3 cloves", "6 leaves",...])
  final List<String> measures;

  // Hàm khởi tạo Meal với các tham số đã khai báo
  MealModel({
    required this.idMeal,
    required this.strMeal,
    this.strMealAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    this.strTags,
    this.strYoutube,
    required this.ingredients,
    required this.measures,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.toString().isNotEmpty && ingredient.toString().trim() != '') {
        ingredients.add(ingredient.toString());
        measures.add(measure?.toString() ?? '');
      }
    }

    return MealModel(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealAlternate: json['strMealAlternate'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      ingredients: ingredients,
      measures: measures,
    );
  }

  factory MealModel.fromFilterJson(Map<String, dynamic> json) {
    return MealModel(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      strCategory: '',
      strArea: '',
      strInstructions: '',
      strTags: null,
      strYoutube: null,
      strMealAlternate: null,
      ingredients: [],
      measures: [],
    );
  }

}
