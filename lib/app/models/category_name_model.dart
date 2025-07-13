class CategoryNameModel {
  final String strCategory;

  CategoryNameModel({required this.strCategory});

  factory CategoryNameModel.fromJson(Map<String, dynamic> json) {
    return CategoryNameModel(
      strCategory: json['strCategory'],
    );
  }
}
