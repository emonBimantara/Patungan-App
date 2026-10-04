import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:patungan/Features/Auth/Model/user_model.dart';
import 'package:patungan/Features/Groups/Controller/group_controller.dart';
import 'package:patungan/Routes/app_routes.dart';
import 'package:patungan/Widgets/group_card.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  final UserModel user;

  const HomeScreen({super.key, required this.token, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GroupController groupController = Get.find<GroupController>();

  @override
  void initState() {
    super.initState();
    groupController.getMyGroups(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8FAFC),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Patungan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2563EB),
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Color(0xFF64748B)),
            onPressed: () {
              context.go(AppRoutes.loginPage);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0xFFDBEAFE),
                    child: Text(
                      "S",
                      style: TextStyle(
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back,",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        widget.user.name ?? "User",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Active Groups",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFDBEAFE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Obx(
                      () => Text(
                        "${groupController.groups.length} Active",
                        style: TextStyle(
                          color: Color(0xFF2563EB),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 14),

              Obx(() {
                if (groupController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (groupController.errorMessage.value.isNotEmpty) {
                  return Text(
                    groupController.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  );
                }

                if (groupController.groups.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Color(0xFFF1F5F9)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.groups_outlined,
                          size: 42,
                          color: Color(0xFF94A3B8),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "No groups yet",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Create a group to start splitting expenses.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: groupController.groups.map((group) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GroupCard(
                        groupName: group.name,
                        memberCount: group.members.length,
                        members: group.members
                            .take(2)
                            .map((member) => member.name)
                            .toList(),
                        onTap: () {},
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Color(0xFF2563EB),
        elevation: 2,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          "Add Group",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
