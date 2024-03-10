class Category {
  final String id;
  final String name;
  final String description;
  final String? parent;

  Category({
    required this.id,
    required this.name,
    this.description = '',
    this.parent,
  });

  factory Category.fromJson(dynamic json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      parent: json['parent'],
    );
  }
}
