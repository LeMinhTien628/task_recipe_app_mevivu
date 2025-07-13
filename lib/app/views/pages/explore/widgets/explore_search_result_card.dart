  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:task/app/models/recipe_model.dart';
  import 'package:task/app/service/favorite_storage.dart';
  import 'package:task/app/views/pages/recipe_detail/recipe_detail_page.dart';

  class ExploreSearchResultCard extends StatefulWidget {
    final RecipeModel recipeModel;

    const ExploreSearchResultCard({
      super.key,
      required this.recipeModel,
    });

    @override
    State<ExploreSearchResultCard> createState() => _ExploreSearchResultCardState();
  }

  class _ExploreSearchResultCardState extends State<ExploreSearchResultCard> {
    late bool _isFavorite;

    @override
    void initState() {
      super.initState();
      // Nếu storage dùng theo title làm key
      _isFavorite = FavoriteStorage.isFavorite(widget.recipeModel.title);
    }

    void _toggleFavorite() {
      setState(() {
        _isFavorite = !_isFavorite;
        if (_isFavorite) {
          FavoriteStorage.addFavorite(widget.recipeModel);
        } else {
          FavoriteStorage.removeFavorite(widget.recipeModel);
        }
      });
    }

    @override
    Widget build(BuildContext context) {
      final recipe = widget.recipeModel;

      return GestureDetector(
        onTap: () {
          Get.to(() => RecipeDetailPage(idMeal: recipe.idMeal ?? ''));
        },
        child: Container(
          width: 160,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ảnh + nút tym
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: recipe.imagePath.startsWith("http")
                        ? Image.network(
                            recipe.imagePath,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            recipe.imagePath,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: _toggleFavorite,
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  recipe.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'By ${recipe.author}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          recipe.time,
                          style: const TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
