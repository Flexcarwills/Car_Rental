import 'package:car_rental_admin/Authentication%20_Screens/auth.dart';
import 'package:car_rental_admin/Introduction/OnboardingScreen.dart';
import 'package:car_rental_admin/Upload_model/uploadcar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const AppDesign(),
  );
}

var kLightColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 252, 221, 232));

var kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 60, 41, 115));

class AppDesign extends StatelessWidget {
  const AppDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Defining the TextTheme for whole application light mode and dark mode
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kLightColorScheme,
        textTheme: const TextTheme(
            bodyMedium: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return const UploadCarScreen();
          }

          return const OnboardingScreen();
        },
      ),
    );
  }
}
