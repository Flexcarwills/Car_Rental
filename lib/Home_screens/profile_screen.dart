import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Profile Avatar
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                      'assets/profile_avatar.jpg'), // Replace with your avatar image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // User data

            // Add more user data as needed
          ],
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//       color: Color.fromARGB(255, 252, 221, 232),
//       themeMode: ThemeMode.light, // or dark
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flex Wheel car'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search, color: Colors.white),
//             onPressed: () {
//               // Add search functionality
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               child: Text(''),
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(200, 250, 210, 200),
//                 borderRadius: BorderRadiusDirectional.zero,
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.account_circle, color: Colors.black),
//               title: Text('Profile'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ProfileScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.settings, color: Colors.black),
//               title: Text('Settings'),
//               onTap: () {
//                 // Add your functionality here
//               },
//             ),
//             // Add more list tiles as needed
//           ],
//         ),
//       ),
//       body: Center(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add your functionality here
//         },
//         child: Icon(Icons.add, color: Colors.white),
//         backgroundColor: Color.fromARGB(255, 260, 45, 115),
//       ),
//     );
//   }
// }
