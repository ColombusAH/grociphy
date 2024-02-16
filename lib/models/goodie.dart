class Goodie {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String addedByUserId;
  final String addedByUserIconUrl;

  Goodie({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.addedByUserId,
    required this.addedByUserIconUrl,
  });

  factory Goodie.fromJson(Map<String, dynamic> json) {
    return Goodie(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      addedByUserId: json['addedByUserId'],
      addedByUserIconUrl: json['addedByUserIconUrl'],
    );
  } 
}
