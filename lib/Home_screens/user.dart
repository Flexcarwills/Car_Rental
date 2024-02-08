import 'package:flutter/material.dart';

class DrawerProfileScreen extends StatefulWidget {
  const DrawerProfileScreen({super.key});

  @override
  State<DrawerProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<DrawerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blueAccent,
          ),
          //SizedBox(height: 20),
        ],
      ),
    );
  }
}
