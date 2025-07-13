class MealApi {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // Tìm kiếm
  static String searchMealByName(String name) => '$baseUrl/search.php?s=$name';
  static String searchMealByFirstLetter(String letter) => '$baseUrl/search.php?f=$letter';
  static String lookupMealById(String id) => '$baseUrl/lookup.php?i=$id';
  static String getRandomMeal() => '$baseUrl/random.php';

  //  Danh sách
  static String listAllCategories() => '$baseUrl/categories.php';
  static String listAllCategoryNames() => '$baseUrl/list.php?c=list';
  static String listAllAreaNames() => '$baseUrl/list.php?a=list';
  static String listAllIngredients() => '$baseUrl/list.php?i=list';

  // Bộ lọc
  static String filterByIngredient(String ingredient) => '$baseUrl/filter.php?i=$ingredient';
  static String filterByCategory(String category) => '$baseUrl/filter.php?c=$category';
  static String filterByArea(String area) => '$baseUrl/filter.php?a=$area';

  //  Ảnh bữa ăn
  static String mealThumbnail(String imagePath, {String size = 'small'}) {
    return 'https://www.themealdb.com/images/media/meals/$imagePath/$size';
  }

  //  Ảnh thành phần (ingredient image)
  static String ingredientImage(String ingredientName, {String size = 'small'}) {
    final name = ingredientName.replaceAll(' ', '_').toLowerCase();
    return 'https://www.themealdb.com/images/ingredients/$name-$size.png';
  }
}
