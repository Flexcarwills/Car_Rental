import 'package:car_rental_admin/Home_screens/user.dart';
import 'package:car_rental_admin/Upload_model/uploadcar.dart';
import 'package:flutter/material.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flex Wheel car'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search,
                color: Colors.white), // Add color property
            onPressed: () {
              // Add search functionality
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8)
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
              )),
              child: const DrawerProfileScreen(),
            ), //
            ListTile(
              leading: const Icon(Icons.account_circle,
                  color: Colors.black), // Add color property
              title: const Text('Profile'),
              onTap: () {
                // Add your functionality here
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings,
                  color: Colors.black), // Add color property
              title: const Text('Settings'),
              onTap: () {
                // Add your functionality here
              },
            ),
            // Add more list tiles as needed
          ],
        ),
      ),
      //body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your functionality here
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const UploadCarScreen()));
        },
        // Add color property
        backgroundColor: Color.fromARGB(255, 260, 45, 115),
        child: const Icon(Icons.add,
            color: Colors.white), // Add backgroundColor property
      ),
    );
  }
}
