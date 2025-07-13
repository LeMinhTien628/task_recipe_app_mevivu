import 'package:flutter/material.dart';

class RecipeCategoryCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String author;
  final String time;

  const RecipeCategoryCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.author,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 160,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Khối nền chính
          Container(
            margin: const EdgeInsets.only(top: 40), // để chừa chỗ ảnh
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F1D9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const SizedBox(height: 32), // chừa chỗ cho ảnh
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.brown,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  'Tạo bởi\n$author',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Colors.brown, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const Icon(Icons.feed_outlined, size: 18),
                  ],
                ),
              ],
            ),
          ),

          // Avatar đè lên
          Positioned(
            top: 0,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(imagePath),
            ),
          ),
        ],
      ),
    );
  }
}
