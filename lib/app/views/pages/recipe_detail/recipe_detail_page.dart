import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:task/app/controllers/meal_controller.dart';
import 'package:task/app/service/favorite_storage.dart';
import 'package:task/app/views/widgets/app_rounded_button.dart';

class RecipeDetailPage extends StatefulWidget {
  final String idMeal;

  const RecipeDetailPage({
    super.key,
    required this.idMeal,
  });

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  bool isIngredientSelected = true;
  late final MealController mealController;

  final List<String> seasoningKeywords = [
    'salt', 'pepper', 'cumin', 'paprika', 'mint', 'thyme',
    'chili', 'onion', 'garlic', 'sugar', 'ginger', 'sauce',
    'spice', 'herb', 'flakes', 'stock', 'bouillon', 'vinegar'
  ];

  @override
  void initState() {
    super.initState();
    mealController = Get.put(MealController(widget.idMeal));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (mealController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final recipe = mealController.recipe.value;
          if (recipe == null) {
            return const Center(child: Text("Không tìm thấy thông tin món ăn."));
          }

          final List<String> ingredients = [];
          final List<String> seasonings = [];

          for (int i = 0; i < (recipe.ingredients?.length ?? 0); i++) {
            final ing = recipe.ingredients?[i].toLowerCase() ?? '';
            final measure = recipe.measures != null && i < recipe.measures!.length
                ? recipe.measures![i]
                : '';
            final full = "• $measure ${recipe.ingredients?[i]}".trim();

            if (seasoningKeywords.any((kw) => ing.contains(kw))) {
              seasonings.add(full);
            } else {
              ingredients.add(full);
            }
          }

          return Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    recipe.imagePath,
                    height: screenHeight / 3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 40,
                    left: 12,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Positioned(
                    top: 50,
                    left: 50,
                    child: Text(
                      "Chi tiết",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 110,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: 6,
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.fromLTRB(10, 16, 10, 16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                recipe.imagePath,
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 30,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        recipe.title,
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      Text(recipe.title, style: const TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                IconButton(
                                icon: Icon(
                                  recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: recipe.isFavorite ? Colors.redAccent : Colors.black,
                                ),
                                onPressed: () {
                                  final updatedRecipe = recipe.copyWith(isFavorite: !recipe.isFavorite);
                                  // Cập nhật trạng thái hiển thị
                                  mealController.recipe.value = updatedRecipe;
                                  // Lưu hoặc gỡ khỏi danh sách yêu thích
                                  FavoriteStorage.toggleFavorite(updatedRecipe);
                                },

                              ),

                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                Text(recipe.rating.toStringAsFixed(1)),
                                const SizedBox(width: 8),
                                Container(width: 1, height: 16, color: Colors.grey),
                                const SizedBox(width: 8),
                                const Text("120 đánh giá", style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: AssetImage(recipe.avatarPath),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  recipe.author,
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 32, color: Colors.amber),
                            Row(
                              children: [
                                Expanded(
                                  child: AppRoundedButton(
                                    text: 'Nguyên liệu',
                                    borderRadius: 10,
                                    backgroundColor: isIngredientSelected ? Colors.amber : Colors.white,
                                    textColor: isIngredientSelected ? Colors.white : Colors.amber,
                                    onPressed: () => setState(() => isIngredientSelected = true),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: AppRoundedButton(
                                    text: 'Chế biến',
                                    borderRadius: 10,
                                    backgroundColor: isIngredientSelected ? Colors.white : Colors.amber,
                                    textColor: isIngredientSelected ? Colors.amber : Colors.white,
                                    onPressed: () => setState(() => isIngredientSelected = false),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Dành cho 2–4 người ăn",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            isIngredientSelected
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 6),
                                      ...ingredients.map((e) => Text(e, style: const TextStyle(fontSize: 15))),
                                      const SizedBox(height: 16),
                                      Text(
                                        "Đối với bột gia vị",
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 6),
                                      ...seasonings.map((e) => Text(e, style: const TextStyle(fontSize: 15))),
                                    ],
                                  )
                                : Text(
                                    recipe.instructions ?? '',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.smart_display, color: Colors.amber),
          label: const Text(
            "Xem video",
            style: TextStyle(color: Colors.amber, fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade100,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
