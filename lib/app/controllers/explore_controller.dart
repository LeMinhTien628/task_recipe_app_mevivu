import 'package:get/get.dart';
import 'package:task/app/controllers/filter_controller.dart';
import 'package:task/app/models/meal_model.dart';
import 'package:task/app/service/meal_service.dart';

class ExploreController extends GetxController {
  var meals = <MealModel>[].obs;
  var isLoading = false.obs;
  final filterController = Get.put(FilterController());

  Future<void> searchByName (String keyWord) async {
    if(keyWord.isEmpty){
      meals.clear();
      return;
    }
    isLoading.value = true;
    final data = await MealService().searchMealByName(keyWord);
    if(data?['meals'] != null){
      meals.value = List<MealModel>.from(
        data!['meals'].map((e) => MealModel.fromJson(e)),
      );
    }
    else{
      meals.clear();
    }
    isLoading.value = false;
  }

  // Lọc
  Future<void> filterMeals(String? category, String? area, String? ingredient) async {
    await filterController.filterMeals(
      category: category,
      area: area,
      ingredient: ingredient,
    );
    meals.value = filterController.filteredMeals;
  }
}