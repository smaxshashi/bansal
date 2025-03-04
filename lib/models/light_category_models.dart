import 'dart:convert';

List<LightCategoryModels> lightCategoryModelsFromJson(String str) =>
    List<LightCategoryModels>.from(
        json.decode(str).map((x) => LightCategoryModels.fromJson(x)));

String lightCategoryModelsToJson(List<LightCategoryModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LightCategoryModels {
  final int categoryId;
  final String categoryName;
  final int categoryCode;
  final String description;
  final int price;
  final String exfield1;
  final dynamic exfield2;
  final DateTime createDate;
  final DateTime modiDate;
  final String wholeseller;

  LightCategoryModels({
    required this.categoryId,
    required this.categoryName,
    required this.categoryCode,
    required this.description,
    required this.price,
    required this.exfield1,
    required this.exfield2,
    required this.createDate,
    required this.modiDate,
    required this.wholeseller,
  });

  factory LightCategoryModels.fromJson(Map<String, dynamic> json) =>
      LightCategoryModels(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        categoryCode: json["categoryCode"],
        description: json["description"],
        price: json["price"],
        exfield1: json["exfield1"],
        exfield2: json["exfield2"],
        createDate: DateTime.parse(json["createDate"]),
        modiDate: DateTime.parse(json["modiDate"]),
        wholeseller: json["wholeseller"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "categoryCode": categoryCode,
        "description": description,
        "price": price,
        "exfield1": exfield1,
        "exfield2": exfield2,
        "createDate": createDate.toIso8601String(),
        "modiDate": modiDate.toIso8601String(),
        "wholeseller": wholeseller,
      };
}
