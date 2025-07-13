import 'package:flutter/material.dart';
import 'package:task/app/views/widgets/app_search_field.dart';

class SearchPage extends StatefulWidget {
  final VoidCallback onClose;
  const SearchPage({super.key, required this.onClose});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> allFoods = [
    "Pizza hến xào",
    "Pipi đút lò",
    "Pizza thơm",
    "Pizza hải sản",
    "Pizza thịt xông khói",
    "Mì Ý bò bằm",
    "Bún chả",
    "Gỏi cuốn tôm thịt",
  ];

  List<String> filteredFoods = [];

  @override
  void initState() {
    super.initState();
    filteredFoods = allFoods;
  }

  void _filterSearch(String query) {
    setState(() {
      filteredFoods = allFoods
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12),
            // Thanh tìm kiếm
            AppSearchField(
              hintText: "Nhập tên món ăn...",
              controller: _searchController,
              onChanged: _filterSearch,
              borderRadius: 10,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),


            const SizedBox(height: 12),

            // Danh sách kết quả
            Expanded(
              child: filteredFoods.isEmpty
                  ? const Center(
                      child: Text(
                        "Không tìm thấy món ăn nào.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredFoods.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredFoods[index]),
                          trailing: const Icon(Icons.chevron_right, color: Colors.amber),
                          onTap: () {
                            // TODO: Chuyển sang trang chi tiết món ăn
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
