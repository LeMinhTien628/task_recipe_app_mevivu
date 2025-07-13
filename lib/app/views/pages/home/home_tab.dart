import 'package:flutter/material.dart';
import 'package:task/app/views/pages/home/home_page.dart';
import 'package:task/app/views/pages/search/search_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isSearching = false;

  void _startSearch() {
    setState(() => isSearching = true);
  }

  void _closeSearch() {
    setState(() => isSearching = false);
  }

  @override
  Widget build(BuildContext context) {
    return isSearching
        ? SearchPage(onClose: _closeSearch)
        : HomePage(onSearchTap: _startSearch);
  }
}
