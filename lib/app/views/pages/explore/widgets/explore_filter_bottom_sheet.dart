import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/controllers/filter_controller.dart';

class ExploreFilterBottomSheet extends StatefulWidget {
  const ExploreFilterBottomSheet({super.key});

  @override
  State<ExploreFilterBottomSheet> createState() => _ExploreFilterBottomSheetState();
}

class _ExploreFilterBottomSheetState extends State<ExploreFilterBottomSheet> {
  String? selectedCategory;
  String? selectedIngredient;
  String? selectedArea;

  final Map<String, bool> sectionExpanded = {
    "Danh mục": false,
    "Nguyên liệu": false,
    "Khu vực": false,
  };

  @override
  Widget build(BuildContext context) {
    final filterController = Get.find<FilterController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Obx(() {
        if (filterController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Thanh kéo
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, size: 36),
                  ),
                ],
              ),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Lọc", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.amber.withOpacity(0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(14),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategory = null;
                        selectedIngredient = null;
                        selectedArea = null;
                        sectionExpanded.updateAll((key, value) => false);
                      });
                    },
                    child: const Text("Đặt lại", style: TextStyle(color: Colors.amber, fontSize: 16)),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              buildSection(
                "Danh mục",
                filterController.categoriesName.map((e) => e.strCategory).toList(),
                selectedCategory,
                (val) => setState(() => selectedCategory = val),
              ),

              const SizedBox(height: 16),

              buildSection(
                "Nguyên liệu",
                filterController.ingredientsName.map((e) => e.strIngredient).toList(),
                selectedIngredient,
                (val) => setState(() => selectedIngredient = val),
              ),

              const SizedBox(height: 16),

              buildSection(
                "Khu vực",
                filterController.areasName.map((e) => e.strArea).toList(),
                selectedArea,
                (val) => setState(() => selectedArea = val),
              ),

              const SizedBox(height: 24),

              // Nút xác nhận
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pop(context, {
                      'category': selectedCategory,
                      'area': selectedArea,
                      'ingredient': selectedIngredient,
                    });
                  },
                  child: const Text("Xác nhận", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildSection(
    String title,
    List<String> items,
    String? selectedItem,
    Function(String) onSelect,
  ) {
    final bool showAll = sectionExpanded[title] ?? false;
    final displayItems = showAll ? items : items.take(8).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.quickreply, size: 18),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: displayItems.map((item) {
            final bool isSelected = item == selectedItem;
            return FilterChip(
              label: Text(item),
              selected: isSelected,
              selectedColor: Colors.amber,
              showCheckmark: false,
              backgroundColor: Colors.grey.shade100,
              labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
              onSelected: (_) => onSelect(item),
            );
          }).toList(),
        ),
        if (items.length > 8)
          TextButton.icon(
            onPressed: () {
              setState(() {
                sectionExpanded[title] = !showAll;
              });
            },
            icon: Icon(showAll ? Icons.expand_less : Icons.expand_more),
            label: Text(showAll ? "Thu gọn" : "Xem thêm"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
      ],
    );
  }
}
