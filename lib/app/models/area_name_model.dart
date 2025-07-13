class AreaNameModel {
  final String strArea;

  AreaNameModel({required this.strArea});

  factory AreaNameModel.fromJson(Map<String, dynamic> json) {
    return AreaNameModel(
      strArea: json['strArea'],
    );
  }
}
