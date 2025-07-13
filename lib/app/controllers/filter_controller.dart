import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/models/area_name_model.dart';
import 'package:task/app/models/category_name_model.dart';
import 'package:task/app/models/ingredient_name_model.dart';
import 'package:task/app/models/meal_model.dart';
import 'package:task/app/service/meal_service.dart';

class FilterController extends GetxController {
  var categoriesName = <CategoryNameModel>[].obs;
  var areasName = <AreaNameModel>[].obs;
  var ingredientsName = <IngredientNameModel>[].obs;
  var isLoading = false.obs;
  var filteredMeals = <MealModel>[].obs;
  var selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadDataFilter();
  }

  Future<void> _loadDataFilter() async {
    isLoading.value = true;
    try {
      final categoryData = await MealService().getCategoryNames();
      final areaData = await MealService().getAreaNames();
      final ingredientData = await MealService().getIngredients();

      if (categoryData?['meals'] != null) {
        categoriesName.value = List<CategoryNameModel>.from(
          categoryData!['meals'].map((e) => CategoryNameModel.fromJson(e)),
        );
      }

      if (areaData?['meals'] != null) {
        areasName.value = List<AreaNameModel>.from(
          areaData!['meals'].map((e) => AreaNameModel.fromJson(e)),
        );
      }

      if (ingredientData?['meals'] != null) {
        ingredientsName.value = List<IngredientNameModel>.from(
          ingredientData!['meals'].map((e) => IngredientNameModel.fromJson(e)),
        );
      }
    } catch (e) {
      debugPrint("Lỗi load filters: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Lọc món ăn theo category, area, ingredient
  Future<void> filterMeals({
    String? category,
    String? area,
    String? ingredient,
  }) async {
    try {
      isLoading.value = true;

      Set<String> resultIds = {};

      // Gọi từng API nếu có giá trị
      final List<Set<String>> idSets = [];

      if (category != null) {
        final res = await MealService().filterByCategory(category);
        if (res?['meals'] != null) {
          final ids = res!['meals'].map<String>((e) => e['idMeal'] as String).toSet();
          idSets.add(ids);
        }
      }

      if (area != null) {
        final res = await MealService().filterByArea(area);
        if (res?['meals'] != null) {
          final ids = res!['meals'].map<String>((e) => e['idMeal'] as String).toSet();
          idSets.add(ids);
        }
      }

      if (ingredient != null) {
        final res = await MealService().filterByIngredient(ingredient);
        if (res?['meals'] != null) {
          final ids = res!['meals'].map<String>((e) => e['idMeal'] as String).toSet();
          idSets.add(ids);
        }
      }

      // Lấy giao các tập ID
      if (idSets.isNotEmpty) {
        resultIds = idSets.reduce((a, b) => a.intersection(b));
      }

      // Lấy chi tiết món ăn từ ID
      List<MealModel> meals = [];
      for (final id in resultIds) {
        final res = await MealService().lookupMealSubById(id);
        if (res?['meals'] != null && res!['meals'].isNotEmpty) {
          meals.add(MealModel.fromJson(res['meals'][0]));
        }
      }

      filteredMeals.value = meals;
    } catch (e) {
      debugPrint("Lỗi lọc món ăn: $e");
      filteredMeals.clear();
    } finally {
      isLoading.value = false;
    }
  }

  // Nhanh hơn nhưng không hiển thị by ...
  //   Future<void> filterMeals({
  //   String? category,
  //   String? area,
  //   String? ingredient,
  // }) async {
  //   try {
  //     isLoading.value = true;

  //     List<Map<String, dynamic>>? categoryMeals;
  //     List<Map<String, dynamic>>? areaMeals;
  //     List<Map<String, dynamic>>? ingredientMeals;

  //     if (category != null) {
  //       final res = await MealService().filterByCategory(category);
  //       if (res?['meals'] != null) {
  //         categoryMeals = List<Map<String, dynamic>>.from(res!['meals']);
  //       }
  //     }

  //     if (area != null) {
  //       final res = await MealService().filterByArea(area);
  //       if (res?['meals'] != null) {
  //         areaMeals = List<Map<String, dynamic>>.from(res!['meals']);
  //       }
  //     }

  //     if (ingredient != null) {
  //       final res = await MealService().filterByIngredient(ingredient);
  //       if (res?['meals'] != null) {
  //         ingredientMeals = List<Map<String, dynamic>>.from(res!['meals']);
  //       }
  //     }

  //     // Giao giữa các danh sách ID
  //     Set<String>? commonIds;

  //     List<List<Map<String, dynamic>>> sources = [categoryMeals, areaMeals, ingredientMeals]
  //       .where((e) => e != null)
  //       .cast<List<Map<String, dynamic>>>()
  //       .toList();

  //     if (sources.isEmpty) {
  //       filteredMeals.clear();
  //       return;
  //     }

  //     // Lấy giao các ID
  //     commonIds = sources.map((list) => list.map((e) => e['idMeal'] as String).toSet())
  //                       .reduce((a, b) => a.intersection(b));

  //     // Duyệt theo 1 trong 3 list gốc và lọc các món có ID trùng
  //     List<Map<String, dynamic>> allMeals = sources.expand((e) => e).toList();
  //     final uniqueMeals = {
  //       for (var e in allMeals)
  //         if (commonIds.contains(e['idMeal'])) e['idMeal']: e
  //     }.values.toList();

  //     // Convert sang MealModel (dạng rút gọn)
  //     filteredMeals.value = uniqueMeals
  //         .map((json) => MealModel.fromFilterJson(json))
  //         .toList();
  //   } catch (e) {
  //     debugPrint("Lỗi lọc món ăn: $e");
  //     filteredMeals.clear();
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

}