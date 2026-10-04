import 'dart:convert';
import 'package:http/http.dart' as http;
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
}
