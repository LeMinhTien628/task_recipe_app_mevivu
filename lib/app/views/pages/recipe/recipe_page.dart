import 'package:flutter/material.dart';
import 'package:task/app/models/recipe_model.dart';
import 'package:task/app/views/widgets/app_recipe_card.dart';
import 'package:task/app/views/widgets/app_rounded_button.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  bool isVideoSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Nội dung cuộn dưới AppBar
            Positioned.fill(
              top: 70,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Bộ lọc Video / Công thức
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppRoundedButton(
                              text: "Video",
                              onPressed: () => setState(() => isVideoSelected = true),
                              backgroundColor: isVideoSelected ? Colors.amber : Colors.amber.shade100,
                              textColor: isVideoSelected ? Colors.white : Colors.amber.shade800,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppRoundedButton(
                              text: "Công thức",
                              onPressed: () => setState(() => isVideoSelected = false),
                              backgroundColor: isVideoSelected ? Colors.amber.shade100 : Colors.amber,
                              textColor: isVideoSelected ? Colors.amber.shade800 : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Danh sách công thức
                    ListView.builder(
                      padding: const EdgeInsets.only(left: 16, bottom: 40),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: RecipeCard(
                            recipe: RecipeModel(
                              imagePath: "assets/images/image.png",
                              title: "Cách chiên trứng một cách công phu ${index + 1}",
                              time: "1 tiếng ${index + 1}0 phút",
                              author: "Lê Minh Tiến",
                              avatarPath: "assets/images/user.png",
                              rating: 4.8,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // AppBar nổi
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.amber),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    const Text(
                      "Công thức",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.amber,
                      ),
                    ),
                    const Spacer(),
                    // IconButton(
                    //   icon: const Icon(Icons.more_vert, color: Colors.amber),
                    //   onPressed: () {},
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
