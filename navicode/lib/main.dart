import 'package:flutter/material.dart';
import 'package:navicode/screens/home_screen.dart';
import 'package:navicode/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naivcode',
      theme: ThemeData(
        textTheme: const TextTheme(),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(253, 203, 157, 1)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      // home: const MyHomeScreen(title: ""),
    );
  }
}
