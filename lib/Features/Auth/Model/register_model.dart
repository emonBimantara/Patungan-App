import 'package:patungan/Features/Auth/Model/user_model.dart';

class RegisterRequest {
  final String name;
  final String email;
  final String password;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}

class RegisterResponse {
  final String status;
  final UserModel user;

  RegisterResponse({
    required this.status,
    required this.user,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return RegisterResponse(
      status: json['status'],
      user: UserModel.fromJson(data['user']),
    );
  }
}