import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:patungan/Features/Auth/Controller/auth_controller.dart';
import 'package:patungan/Routes/app_routes.dart';
import 'package:patungan/Widgets/custom_button.dart';
import 'package:patungan/Widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 150),
                      Icon(Icons.note_add_sharp, size: 70),
                      SizedBox(height: 10),
                      Text(
                        "Patungan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "Split group expenses simply and fairly",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ],
                  ),
                ),
        
                SizedBox(height: 50),
        
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email Address",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      controller: emailController,
                      hintText: "email@gmail.com",
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
        
                SizedBox(height: 10),
        
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "********",
                      obscureText: true,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
        
                SizedBox(height: 20),
        
                SizedBox(
                  height: 20,
                  child: Obx(
                    () => Text(
                      authController.errorMessage.value,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
        
                SizedBox(height: 20),
                Obx(
                  () => GestureDetector(
                    onTap: authController.isLoading.value
                        ? null
                        : () {
                            authController.login(
                              context,
                              emailController.text,
                              passwordController.text,
                            );
                          },
                    child: CustomButton(
                      text: "Login",
                      isLoading: authController.isLoading.value,
                    ),
                  ),
                ),
                SizedBox(height: 20),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.registerPage);
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Color(0xFF2563EB),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
