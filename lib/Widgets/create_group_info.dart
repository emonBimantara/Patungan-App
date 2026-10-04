import 'package:flutter/material.dart';

class CreateGroupInfo extends StatelessWidget {
  const CreateGroupInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        "This payment info will be shown to group members when they view their personal summary to transfer payment.",
        style: TextStyle(
          color: Color(0xFFB45309),
          fontWeight: FontWeight.w600,
          
        ),
      ),
    );
  }
}
