class ProductAttributesModel {
  String? name;
  List<String>? values;

  ProductAttributesModel({this.name, this.values});

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Values': values,
    };
  }

  factory ProductAttributesModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductAttributesModel();

    return ProductAttributesModel(
        name: data.containsKey('Name') ? data['Name'] : '',
        values: List<String>.from(data['Values']));
  }
}
