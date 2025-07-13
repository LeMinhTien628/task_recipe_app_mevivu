import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:task/app/models/recipe_model.dart';
import 'package:task/app/service/meal_service.dart';

class MealController extends GetxController {
  final String id;
  MealController(this.id);

  var isLoading = false.obs;
  var recipe = Rxn<RecipeModel>(); // dữ liệu món ăn

  @override
  void onInit() {
    super.onInit();
    getMealDetail();
  }

  Future<void> getMealDetail() async {
    try {
      isLoading.value = true;

      // Gọi service để lấy RecipeModel
      final meal = await MealService().lookupMealById(id);
      if (meal != null) {
        recipe.value = meal;
      } else {
        debugPrint("Không tìm thấy món ăn với id: $id");
      }

    } catch (e) {
      debugPrint('Lỗi lấy chi tiết món ăn: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
