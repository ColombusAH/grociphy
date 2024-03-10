class GroupMember{
  final String id;
  final String name;
  final String avatar;

  GroupMember({required this.id, required this.name, this.avatar = ''});

  factory GroupMember.fromJson(dynamic json){
    return GroupMember(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'] ?? '',
    );
  }
}