import 'package:flutter_first_app/models/category.dart';
import 'package:flutter_first_app/models/group_member.dart';

class ProductInList {
  final String id;
  final String name;
  final String description;
  final String unit;
  final String categoryId;
  final int quantity;
  final Category category;
  final GroupMember addedBy;
  final bool isGrabbed;

  ProductInList({
    required this.id,
    required this.name,
    this.description = '',
    required this.unit,
    required this.isGrabbed,
    required this.categoryId,
    required this.quantity,
    required this.category,
    required this.addedBy,
  });

  factory ProductInList.fromJson(dynamic json) {
    final product = json['product'];
    final category = product['category'];
    final addedBy = json['addedBy'];  

    return ProductInList(
      id: json['id'],
      name: product['name'],
      description: product['description'] ?? '',
      unit: product['unit'],
      categoryId: product['categoryId'],
      quantity: json['quantity'],
      isGrabbed: json['isGrabbed'],
      category: Category.fromJson(category),
      addedBy: GroupMember.fromJson(addedBy),
    );
  }
}
