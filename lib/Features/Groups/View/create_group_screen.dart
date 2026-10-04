import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patungan/Routes/app_routes.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8FAFC),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Create Group",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2563EB),
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF64748B)),
          onPressed: () {
            context.go(AppRoutes.homePage);
          },
        ),
      ),
    );
  }
}
