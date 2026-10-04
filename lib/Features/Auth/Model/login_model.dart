import 'package:patungan/Features/Auth/Model/user_model.dart';

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}

class LoginResponse {
  final String status;
  final UserModel user;
  final String token;

  LoginResponse({
    required this.status,
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return LoginResponse(
      status: json['status'],
      user: UserModel.fromJson(data['user']),
      token: data['token'],
    );
  }
}