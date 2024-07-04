//import 'package:flutter/foundation.dart';

enum DiscountType { Coupon, OnTop, Seasonal }
enum Category { All, Clothing, Accessories, Electronics }

class DiscountModel {
  final String id;
  final DiscountType type;
  final String parameters; // Either "amount" or "percentage"
  final double amount;
  final double? max;
  final double? min;
  final Category category;
  final double? everyAmount; // Nullable, used for Seasonal type
  final String? name;
  final String? description;


  DiscountModel({
    required this.id,
    required this.type,
    required this.parameters,
    required this.amount,
    this.max,
    this.min,
    required this.category,
    this.everyAmount,
    this.name,
    this.description,
  });

  // Factory constructor to create a DiscountModel from JSON
  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      id: json['id'],
      type: DiscountType.values.firstWhere((e) => e.name == json['type']),
      parameters: json['parameters'],
      amount: json['amount'],
      max: json['max'],
      min: json['min'],
      category: Category.values.firstWhere((e) => e.name == json['category']),
      everyAmount: json['everyAmount'],
      name: json['name'],
      description: json['description'],
    );
  }

  // Method to convert a DiscountModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'parameters': parameters,
      'amount': amount,
      'max': max,
      'min': min,
      'category': category.name,
      'everyAmount': everyAmount,
      'name': name,
      'description': description,
    };
  }
}
