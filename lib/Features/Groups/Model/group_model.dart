import 'member_model.dart';

class Group {
  final String id;
  final String name;
  final List<Member> members;

  Group({
    required this.id,
    required this.name,
    required this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      members: (json['members'] as List)
          .map((member) => Member.fromJson(member))
          .toList(),
    );
  }
}