//import 'package:flutter/foundation.dart';

enum ItemCategory { Clothing, Accessories, Electronics }

class ItemModel {
  final String id;
  final String name;
  final double price;
  final ItemCategory category;

  ItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  // Factory constructor to create an ItemModel from JSON
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      category: ItemCategory.values.firstWhere((e) => e.name == json['category']),
    );
  }

  // Method to convert an ItemModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category.name,
    };
  }
}
