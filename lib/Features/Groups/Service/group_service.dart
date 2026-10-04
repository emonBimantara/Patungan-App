import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patungan/Features/Groups/Model/add_member_model.dart';
import 'package:patungan/Features/Groups/Model/create_group_model.dart';
import 'package:patungan/Features/Groups/Model/group_detail_model.dart';
import 'package:patungan/Features/Groups/Model/group_model.dart';

class GroupService {
  final String baseUrl = 'https://patungan-api-production.up.railway.app';

  Future<List<Group>> getMyGroups(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/groups'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final groups = data['data']['groups'] as List;

      return groups.map((group) => Group.fromJson(group)).toList();
    }

    throw Exception('Failed to fetch groups');
  }

  Future<CreateGroupResponse> createGroup(
    String token,
    CreateGroupRequest request,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/groups'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      return CreateGroupResponse.fromJson(jsonDecode(response.body));
    }

    final errorData = jsonDecode(response.body);

    throw Exception(errorData['error'] ?? 'Failed to create group');
  }

  Future<GroupDetail> getGroupDetail(String token, String groupId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/groups/$groupId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return GroupDetail.fromJson(data['data']['group']);
    }

    final errorData = jsonDecode(response.body);

    throw Exception(errorData['error'] ?? 'Failed to fetch group detail');
  }

  Future<void> addMember(
    String token,
    String groupId,
    AddMemberRequest request,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/groups/$groupId/members'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      return;
    }

    print('ADD MEMBER STATUS: ${response.statusCode}');
    print('ADD MEMBER BODY: ${response.body}');

    final errorData = jsonDecode(response.body);

    throw Exception(
      errorData['error'] ?? errorData['message'] ?? 'Failed to add member',
    );
  }
}
