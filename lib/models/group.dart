import 'package:flutter_first_app/models/group_member.dart';
import 'package:flutter_first_app/models/product_in_list.dart';

class Group {
  final String id;
  final String name;
  final String description;
  final String ownerId;
  final List<GroupMember> members; // Consider creating a Member model if more details are needed
  final List<ProductInList> products;

  Group({
    required this.id,
    required this.name,
    this.description = '',
    required this.ownerId,
    required this.members,
    required this.products,
  });

  factory Group.fromJson(dynamic json) {
    final memberList = json['members'] as List;
    final productList = json['products'] as List;
    // print(productList);
    List<ProductInList> products = (productList).map((productJson) {
      return ProductInList.fromJson(productJson..putIfAbsent('quantity', () => productJson['quantity']));
    }).toList();

    List<GroupMember> members = (memberList).map((memberJson) {
      return GroupMember.fromJson(memberJson);
    }).toList();

    return Group(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      ownerId: json['ownerId'],
      members: members,
      products: products,
    );
  }

}

