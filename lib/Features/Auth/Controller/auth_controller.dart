import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:patungan/Features/Auth/Model/login_model.dart';
import 'package:patungan/Features/Auth/Model/register_model.dart';
import 'package:patungan/Features/Auth/Service/auth_service.dart';
import 'package:patungan/Features/Auth/Service/auth_storage.dart';
import 'package:patungan/Routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService authService;
  final AuthStorage authStorage;

  AuthController({required this.authService, required this.authStorage});

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    errorMessage.value = '';
    isLoading.value = true;

    try {
      final request = LoginRequest(email: email, password: password);
      final response = await authService.login(request);

      await authStorage.saveSession(
        token: response.token,
        userId: response.user.id,
        userName: response.user.name ?? '',
        userEmail: response.user.email,
      );

      if (context.mounted) {
        context.go(
          '/home',
          extra: {'token': response.token, 'user': response.user},
        );
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(
    BuildContext context,
    String name,
    String email,
    String password,
  ) async {
    errorMessage.value = '';
    isLoading.value = true;

    try {
      final request = RegisterRequest(
        name: name,
        email: email,
        password: password,
      );
      await authService.register(request);

      if (context.mounted) {
        context.go(AppRoutes.loginPage);
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout(BuildContext context) async {
    if (context.mounted) {
      context.go(AppRoutes.loginPage);
    }
  }

  Future<Map<String, String>?> getSession() async {
    return await authStorage.getSession();
  }
}
