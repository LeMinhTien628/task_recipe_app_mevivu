import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task/app/models/recipe_model.dart';
import '../utils/constants/meal_api.dart';

class MealService {
  // Tìm kiếm bữa ăn theo tên
  Future<Map<String, dynamic>?> searchMealByName(String name) async {
    final response = await http.get(Uri.parse(MealApi.searchMealByName(name)));
    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    return null;
  }

  // Tìm kiếm theo chữ cái đầu
  Future<Map<String, dynamic>?> searchMealByFirstLetter(String letter) async {
    final response = await http.get(Uri.parse(MealApi.searchMealByFirstLetter(letter)));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  // Lấy chi tiết theo ID
  Future<RecipeModel?> lookupMealById(String id) async {
    final response = await http.get(Uri.parse(MealApi.lookupMealById(id)));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded is Map<String, dynamic> && decoded['meals'] != null) {
        final meal = decoded['meals'][0];
        if (meal is Map<String, dynamic>) {
          return RecipeModel.fromJson(meal);
        } else {
          debugPrint('meal không phải Map: $meal');
        }
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> lookupMealSubById(String id) async {
    final response = await http.get(Uri.parse(MealApi.lookupMealById(id)));
    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    return null;
  }

  // Bữa ăn ngẫu nhiên
  Future<Map<String, dynamic>?> getRandomMeal() async {
    final response = await http.get(Uri.parse(MealApi.getRandomMeal()));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  // Danh mục, khu vực, thành phần
  Future<Map<String, dynamic>?> getCategories() async {
    final response = await http.get(Uri.parse(MealApi.listAllCategories()));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>?> getCategoryNames() async {
    final response = await http.get(Uri.parse(MealApi.listAllCategoryNames()));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>?> getAreaNames() async {
    final response = await http.get(Uri.parse(MealApi.listAllAreaNames()));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  // Lấy nguyên liệu
  Future<Map<String, dynamic>?> getIngredients() async {
    final response = await http.get(Uri.parse(MealApi.listAllIngredients()));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  // Lọc
  Future<Map<String, dynamic>?> filterByIngredient(String ingredient) async {
    final response = await http.get(Uri.parse(MealApi.filterByIngredient(ingredient)));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>?> filterByCategory(String category) async {
    final response = await http.get(Uri.parse(MealApi.filterByCategory(category)));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>?> filterByArea(String area) async {
    final response = await http.get(Uri.parse(MealApi.filterByArea(area)));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }
}
