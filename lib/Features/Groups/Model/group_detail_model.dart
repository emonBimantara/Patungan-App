import 'package:patungan/Features/Groups/Model/member_model.dart';

class GroupDetail {
  final String id;
  final String name;
  final String createdAt;
  final String paymentInfo;
  final String createdById;
  final Member createdBy;
  final List<Member> groupMembers;

  GroupDetail({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.paymentInfo,
    required this.createdById,
    required this.createdBy,
    required this.groupMembers,
  });

  factory GroupDetail.fromJson(Map<String, dynamic> json) {
    return GroupDetail(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      paymentInfo: json['paymentInfo'],
      createdById: json['createdById'],
      createdBy: Member.fromJson(json['createdBy']),
      groupMembers: (json['groupMembers'] as List)
          .map((member) => Member.fromJson(member['user']))
          .toList(),
    );
  }
}
