// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:task/app/views/pages/add_recipe/add_recipe_page.dart';
import 'package:task/app/views/pages/explore/explore_page.dart';
import 'package:task/app/views/pages/home/home_tab.dart';
import 'package:task/app/views/pages/profile/profile_page.dart';
import 'package:task/app/views/pages/recipe/recipe_page.dart';

class MainScreen extends StatefulWidget {
  int seletedIndex;
  MainScreen({
    super.key,
    required this.seletedIndex,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex = 0;
  late PageController _pageController;
  

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
    _selectedIndex = widget.seletedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // xuyên 
      // Nội dung có thể vuốt
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          HomeTab(), 
          ExplorePage(),
          AddRecipePage(),
          RecipePage(),
          ProfilePage(),
        ],
      ),

      // Nút floating "+"
      floatingActionButton: SizedBox(
        width: 70,   
        height: 70,  
        child: FloatingActionButton(
          onPressed: () => _onItemTapped(2),
          backgroundColor: Colors.amber,
          elevation: 6,
          shape: const CircleBorder(), 
          child: const Icon(Icons.add, size: 36, color: Colors.white), // 👈 Icon to hơn
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 

      // Bottom nav
      bottomNavigationBar: BottomAppBar(
        // Lỏm icon ở giữa
        shape: const CircularNotchedRectangle(),
        notchMargin: 16, // lỏm sâu hơn
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home,
                    color: _selectedIndex == 0 ? Colors.amber : Colors.grey),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.search,
                    color: _selectedIndex == 1 ? Colors.amber : Colors.grey),
                onPressed: () => _onItemTapped(1),
              ),
              const SizedBox(width: 40), // chừa chỗ cho FAB
              IconButton(
                icon: Icon(Icons.bookmark_border,
                    color: _selectedIndex == 3 ? Colors.amber : Colors.grey),
                onPressed: () => _onItemTapped(3),
              ),
              IconButton(
                icon: Icon(Icons.person_outline,
                    color: _selectedIndex == 4 ? Colors.amber : Colors.grey),
                onPressed: () => _onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
