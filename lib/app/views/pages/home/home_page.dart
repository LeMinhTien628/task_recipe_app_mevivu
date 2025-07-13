import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/controllers/category_controller.dart';
import 'package:task/app/controllers/ingredient_controller.dart';
import 'package:task/app/controllers/filter_controller.dart';
import 'package:task/app/models/recipe_model.dart';
import 'package:task/app/service/favorite_storage.dart';
import 'package:task/app/views/widgets/app_recipe_card.dart';
import 'package:task/app/views/pages/home/widgets/recipe_category_card.dart';
import 'package:task/app/views/pages/home/widgets/recipe_simple_card.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onSearchTap;
  const HomePage({super.key, required this.onSearchTap});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  
  final CategoryController categoryController = Get.put(CategoryController());
  final IngredientController ingredientController = Get.put(IngredientController());
  final FilterController filterController = Get.put(FilterController());
  late List<RecipeModel> recipeList;
  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  void _loadRecipes() {
    final favorites = FavoriteStorage.getFavorites();
    setState(() {
      recipeList = List.generate(10, (index) {
        final title = "Cách chiên trứng một cách công phu ${index + 1}";
        final isFav = favorites.any((r) => r.title == title);
        return RecipeModel(
          imagePath: "assets/images/image.png",
          title: title,
          time: "1 tiếng ${index + 1}0 phút",
          author: "Lê Minh Tiến",
          avatarPath: "assets/images/user.png",
          rating: 4.8,
          isFavorite: isFav,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Thanh tìm kiếm
              GestureDetector(
                onTap: widget.onSearchTap,
                child: AbsorbPointer(
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "Tìm kiếm sản phẩm",
                      hintStyle: TextStyle(fontSize: 18),
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              //Khu vực & video nổi bật
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("TP. Hồ Chí Minh", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text("Xem tất cả", style: TextStyle(color: Colors.amber, fontSize: 20)),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 290,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recipeList.length,
                  itemBuilder: (context, index) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    return SizedBox(
                      width: screenWidth * 0.6,
                      child: RecipeCard(
                        recipe: recipeList[index],
                        onFavoriteToggled: () {
                          setState(() {
                            _loadRecipes(); // cập nhật lại từ FavoriteStorage
                          });
                        },
                      ),

                    );
                  },
                ),
              ),


              const SizedBox(height: 24),

              // Danh mục
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Danh mục", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text("Xem tất cả", style: TextStyle(color: Colors.amber, fontSize: 20)),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 44,
                child: Obx(() {
                  if (categoryController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (categoryController.categories.isEmpty) {
                    return const Center(child: Text("Không có danh mục nào."));
                  }
                  return ListView.builder(
                    itemCount: categoryController.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final category = categoryController.categories[index];
                      return _buildCategory(category.strCategory);
                    },
                  );
                }),
              ),

              const SizedBox(height: 20),

              Obx(() {
                if (filterController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (filterController.filteredMeals.isEmpty) {
                  return const Center(child: Text("Không có món ăn nào."));
                }
                return SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filterController.filteredMeals.length,
                    itemBuilder: (context, index) {
                      final meal = filterController.filteredMeals[index];
                      return RecipeCategoryCard(
                        imagePath: meal.strMealThumb,
                        title: meal.strMeal,
                        author: meal.strArea,
                        time: '20 phút',
                      );
                    },
                  ),
                );
              }),

              const SizedBox(height: 24),

              // Công thức gần đây
              const Text("Công thức gần đây", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 20),
              SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return RecipeSimpleCard(
                      imagePath: 'assets/images/food1.png',
                      title: 'Trứng chiên',
                      authorName: 'Lê Minh Tiến',
                      authorAvatar: 'assets/images/user.png',
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Nguyên liệu
              const Text("Nguyên liệu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: Obx(() {
                  if (ingredientController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GridView.count(
                    crossAxisCount: 2,
                    scrollDirection: Axis.horizontal,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / 2,
                    children: List.generate(
                      ingredientController.ingredients.length,
                      (index) {
                        final ingredient = ingredientController.ingredients[index];
                        return _buildIngredient(ingredient.strIngredient);
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(String title) {
    return Obx(() {
      final isSelected = filterController.selectedCategory.value == title;
      return GestureDetector(
        onTap: () {
          if (isSelected) {
            filterController.selectedCategory.value = '';
            filterController.filteredMeals.clear();
          } else {
            filterController.selectedCategory.value = title;
            filterController.filterMeals(category: title);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.amber : Colors.white,
            border: Border.all(width: 1, color: Colors.grey.shade200),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.amber,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildIngredient(String title) {
    return Obx(() {
      final isSelected = ingredientController.selectedIngredient.value == title;
      return GestureDetector(
        onTap: () {
          if (isSelected) {
            ingredientController.selectedIngredient.value = '';
          } else {
            ingredientController.selectedIngredient.value = title;
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.amber : Colors.white,
            border: Border.all(width: 1, color: Colors.grey.shade200),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.amber,
            ),
          ),
        ),
      );
    });
  }
}
