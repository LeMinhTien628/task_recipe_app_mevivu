import 'package:flutter/material.dart';

class RecipeSimpleCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String authorName;
  final String authorAvatar;

  const RecipeSimpleCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.authorName,
    required this.authorAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ảnh món ăn
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            width: 140,
            height: 140,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),

        // Tên món ăn
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 8),

        // Avatar + Tên người tạo
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage(authorAvatar),
            ),
            const SizedBox(width: 6),
            Text(
              authorName,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    ),
    );
    
  }
}
