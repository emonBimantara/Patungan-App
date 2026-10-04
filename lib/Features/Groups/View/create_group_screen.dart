import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:patungan/Features/Auth/Service/auth_storage.dart';
import 'package:patungan/Features/Groups/Controller/group_controller.dart';
import 'package:patungan/Routes/app_routes.dart';
import 'package:patungan/Widgets/create_group_info.dart';
import 'package:patungan/Widgets/custom_button.dart';
import 'package:patungan/Widgets/custom_text_field.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController paymentInfoController = TextEditingController();

  final GroupController groupController = Get.find<GroupController>();

  Future<void> createGroup() async {
    final authStorage = AuthStorage();
    final session = await authStorage.getSession();

    if (session == null) {
      return;
    }

    final response = await groupController.createGroup(
      session['token']!,
      groupNameController.text,
      paymentInfoController.text,
    );

    if (response != null && mounted) {
      await groupController.getMyGroups(session['token']!);

      if (mounted) {
        context.pop();
      }
    }
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Group Name",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: groupNameController,
                hintText: "Weekend Hangout",
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
        
              SizedBox(height: 30),
        
              Text(
                "Payment Info (Bank Account / e-Wallet)",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: paymentInfoController,
                hintText: "PAYPAL - 1234567890",
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
        
              SizedBox(height: 30),
              CreateGroupInfo(),
              SizedBox(height: 30),
        
              Obx(
                () => GestureDetector(
                  onTap: groupController.isLoading.value ? null : createGroup,
                  child: CustomButton(
                    text: "Create Group",
                    isLoading: groupController.isLoading.value,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
