import 'package:get_storage/get_storage.dart';
import '../models/recipe_model.dart';

class FavoriteStorage {
  static final _box = GetStorage();
  static const _key = 'favorites';

  static List<RecipeModel> getFavorites() {
    final data = _box.read<List>(_key) ?? [];
    return data.map((e) => RecipeModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  static void addFavorite(RecipeModel recipe) {
    final current = getFavorites();
    current.add(recipe);
    _box.write(_key, current.map((e) => e.toJson()).toList());
  }

  static void removeFavorite(RecipeModel recipe) {
    final current = getFavorites();
    current.removeWhere((item) => item.title == recipe.title);
    _box.write(_key, current.map((e) => e.toJson()).toList());
  }

  static bool isFavorite(String title) {
    final current = getFavorites();
    return current.any((r) => r.title == title);
  }

  static void toggleFavorite(RecipeModel recipe) {
    final isFav = isFavorite(recipe.title);
    if (isFav) {
      removeFavorite(recipe);
    } else {
      addFavorite(recipe);
    }
  }
}
