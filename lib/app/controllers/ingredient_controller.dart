import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:task/app/models/ingredient_model.dart';
import 'package:task/app/service/meal_service.dart';

class IngredientController extends GetxController{
  var ingredients  = <IngredientModel>[].obs;
  var isLoading = false.obs;
  var selectedIngredient = ''.obs;

  @override
  void onInit(){
    super.onInit();
    getIngredients();
  }

  Future<void> getIngredients() async{
    isLoading.value = true;
    try{
      final data = await MealService().getIngredients();
      if(data?['meals'] != null){
        ingredients.value = List<IngredientModel>.from(
          data!['meals'].map((e) => IngredientModel.fromJson(e))
        );
      }
    }catch(e){
      debugPrint("Lỗi nguyên liệu: $e");
    }finally {
      isLoading.value = false;
    }
  }
}