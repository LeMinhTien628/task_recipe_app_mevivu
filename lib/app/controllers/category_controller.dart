import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/models/category_model.dart';
import 'package:task/app/service/meal_service.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var isLoading = false.obs;
  var selectedCategory = ''.obs;

  @override
  void onInit(){
    super.onInit();
    getCategories();
  }

  Future<void> getCategories() async{
    isLoading.value = true;
    try{
      final data = await MealService().getCategories();
      if(data?['categories'] != null){
        categories.value = List<CategoryModel>.from(
          data!['categories'].map((e) => CategoryModel.fromJson(e))
        );
      }
      else{
        categories.clear();
      }
    }catch(e){
      debugPrint("Lỗi không tìm thấy mục: $e");
      categories.clear();
    }finally {
      isLoading.value = false;
    }
  }
  void selectCategory(String name) {
    selectedCategory.value = name;
  }
}