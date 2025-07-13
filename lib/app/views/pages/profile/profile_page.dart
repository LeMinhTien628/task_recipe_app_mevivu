import 'package:flutter/material.dart';
import 'package:task/app/models/recipe_model.dart';
import 'package:task/app/service/favorite_storage.dart';
import 'package:task/app/views/widgets/app_rounded_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<RecipeModel> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      favorites = FavoriteStorage.getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: 70, // để chừa chỗ cho AppBar
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // Avatar + Tên
                    const CircleAvatar(
                      radius: 44,
                      backgroundImage: AssetImage("assets/images/user.png"),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Lê Minh Tiến",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.amber),
                    ),

                    const SizedBox(height: 16),

                    // Thống kê
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buidStatItem(title: "Bài viết", count: 100),
                          _buidLine(),
                          _buidStatItem(title: "Người theo dõi", count: 100),
                          _buidLine(),
                          _buidStatItem(title: "Theo dõi", count: 100),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Follow & Message
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppRoundedButton(
                          text: "Follow",
                          onPressed: () {},
                          backgroundColor: Colors.amber,
                          textColor: Colors.white,
                        ),
                        const SizedBox(width: 12),
                        AppRoundedButton(
                          text: "Message",
                          onPressed: () {},
                          backgroundColor: Colors.amber.shade100,
                          textColor: Colors.amber.shade800,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Danh sách yêu thích",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 40),
                      child: favorites.isEmpty
                          ? const Text("Chưa có món nào được yêu thích.")
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: favorites.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                final recipe = favorites[index];
                               return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                  child: recipe.imagePath.startsWith('http')
                                  ? Image.network(
                                      recipe.imagePath,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      recipe.imagePath,
                                      fit: BoxFit.cover,
                                    ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),

            // 📌 AppBar cố định trên cùng
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                        width: 1, color: Colors.grey.withOpacity(0.2)),
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
                      "Trang cá nhân",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.amber),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.amber),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buidStatItem({required String title, required int count}) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 14)),
        Text('$count',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ],
    );
  }

  Widget _buidLine() {
    return Container(
      width: 1,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
    );
  }
}
