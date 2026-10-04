import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:patungan/Features/Auth/Controller/auth_controller.dart';
import 'package:patungan/Routes/app_routes.dart';
import 'package:patungan/Widgets/custom_button.dart';
import 'package:patungan/Widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 150),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Create Account",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Join Patungan to manage shared bills",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                  ],
                ),
          
                SizedBox(height: 30),
          
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    CustomTextField(
                      controller: nameController,
                      hintText: "e.g King Solo",
                      obscureText: false,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
          
                SizedBox(height: 15),
          
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
          
                SizedBox(height: 15),
          
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
          
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    authController.register(
                      context,
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                    );
                  },
                  child: CustomButton(text: "Register", isLoading: false),
                ),
                SizedBox(height: 20),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.loginPage);
                      },
                      child: Text(
                        "Login",
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
