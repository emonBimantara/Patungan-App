import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:patungan/Features/Auth/Binding/auth_binding.dart';
import 'package:patungan/Features/Auth/Controller/auth_controller.dart';
import 'package:patungan/Features/Auth/Model/user_model.dart';
import 'package:patungan/Features/Auth/View/login_screen.dart';
import 'package:patungan/Features/Auth/View/register_screen.dart';

import 'package:patungan/Features/Groups/Binding/group_binding.dart';
import 'package:patungan/Features/Groups/View/home_screen.dart';

import 'package:patungan/Routes/app_routes.dart';

Future<GoRouter> createAppRouter(Map<String, String>? session) async {
  AuthBinding().dependencies();

  final authController = Get.find<AuthController>();
  final session = await authController.getSession();

  return GoRouter(
    initialLocation: session == null ? AppRoutes.loginPage : '/home',

    routes: [
      GoRoute(
        path: AppRoutes.loginPage,
        builder: (context, state) {
          AuthBinding().dependencies();
          return const LoginScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.registerPage,
        builder: (context, state) {
          AuthBinding().dependencies();
          return const RegisterScreen();
        },
      ),

      GoRoute(
        path: '/home',
        redirect: (context, state) {
          if (session == null && state.extra == null) {
            return AppRoutes.loginPage;
          }

          return null;
        },
        builder: (context, state) {
          GroupBinding().dependencies();

          final extra = state.extra as Map<String, dynamic>?;

          final token = extra?['token'] as String? ?? session?['token'];

          final user =
              extra?['user'] as UserModel? ??
              (session == null
                  ? null
                  : UserModel(
                      id: session['userId']!,
                      name: session['userName'],
                      email: session['userEmail']!,
                    ));

          if (token == null || user == null) {
            return const Scaffold(
              body: Center(
                child: Text('Session not found. Please log in again.'),
              ),
            );
          }

          return HomeScreen(token: token, user: user);
        },
      ),
    ],
  );
}