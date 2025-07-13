import 'package:flutter/material.dart';
import 'package:task/app/models/recipe_model.dart';
import 'package:task/app/service/favorite_storage.dart';

class RecipeCard extends StatefulWidget {
  final RecipeModel recipe;
  final void Function()? onFavoriteToggled;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onFavoriteToggled,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = FavoriteStorage
        .getFavorites()
        .any((r) => r.title == widget.recipe.title);
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      if (_isFavorite) {
        FavoriteStorage.addFavorite(widget.recipe);
      } else {
        FavoriteStorage.removeFavorite(widget.recipe);
      }
    });

    widget.onFavoriteToggled?.call(); // Gọi callback nếu có
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return GestureDetector(
      onTap: () {
        // TODO: Điều hướng tới RecipeDetailPage nếu cần
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    recipe.imagePath,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 6,
                  child: Chip(
                    backgroundColor: Colors.yellow,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.white),
                        const SizedBox(width: 2),
                        Text(
                          recipe.rating.toStringAsFixed(1),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const Positioned.fill(
                  child: Center(
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.amber, size: 28
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // ⏱ Time + ❤️ Favorite
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        recipe.time,
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: _toggleFavorite,
                        child: Icon(
                          _isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              _isFavorite ? Colors.redAccent : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      recipe.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(recipe.avatarPath),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        recipe.author,
                        style: const TextStyle(
                            color: Colors.amber, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
