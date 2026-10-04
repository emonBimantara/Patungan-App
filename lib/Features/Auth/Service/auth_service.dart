import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:patungan/Features/Auth/Model/login_model.dart';
import 'package:patungan/Features/Auth/Model/register_model.dart';

class AuthService {
  final String baseUrl = 'https://patungan-api-production.up.railway.app';

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    }

    final errorData = jsonDecode(response.body);
    throw Exception(errorData['message'] ?? 'Login failed');
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(jsonDecode(response.body));
    }

    final errorData = jsonDecode(response.body);
    throw Exception(errorData['error'] ?? 'Login failed');
  }
}
