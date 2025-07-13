import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/controllers/explore_controller.dart';
import 'package:task/app/models/recipe_model.dart';
import 'package:task/app/views/pages/explore/widgets/explore_filter_bottom_sheet.dart';
import 'package:task/app/views/pages/explore/widgets/explore_search_result_card.dart';
import 'package:task/app/views/widgets/app_search_field.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});

  final TextEditingController _searchController = TextEditingController();
  final ExploreController exploreController = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //Thanh tìm kiếm + icon lọc
            Row(
              children: [
                Expanded(
                  child: AppSearchField(
                    controller: _searchController,
                    onChanged: (query) {
                      exploreController.searchByName(query);
                    },
                    hintText: "Tìm món ăn, công thức...",
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.filter_alt, color: Colors.amber, size: 40),
                  onPressed: () async {
                    final result = await showModalBottomSheet<Map<String, String?>>(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (context) => const ExploreFilterBottomSheet(),
                    );

                    if (result != null) {
                      exploreController.filterMeals(
                        result['category'],
                        result['area'],
                        result['ingredient'],
                      );
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Danh sách kết quả tìm kiếm
            Expanded(
              child: Obx(() {
                if (exploreController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (exploreController.meals.isEmpty) {
                  return const Center(child: Text("Không tìm thấy món ăn nào."));
                }

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 50),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 12,
                    childAspectRatio: 3 / 3.5,
                  ),
                  itemCount: exploreController.meals.length,
                  itemBuilder: (context, index) {
                    final meal = exploreController.meals[index];

                    final recipe = RecipeModel(
                      idMeal: meal.idMeal,
                      imagePath: meal.strMealThumb,
                      title: meal.strMeal,
                      time: "20 phút",
                      author: meal.strArea,
                      avatarPath: "assets/images/user.png", 
                      rating: 4.5, 
                      isFavorite: false, 
                    );

                    return ExploreSearchResultCard(recipeModel: recipe);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
