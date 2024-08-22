import 'package:flutter/material.dart';
import 'package:navicode/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naivcode',
      debugShowCheckedModeBanner: false, // Debug Banner 제거
      theme: ThemeData(
        textTheme: const TextTheme(),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(253, 203, 157, 1)),
        useMaterial3: true,
      ),
      home: const MyHomeScreen(title: ""),
      // home: const MyHomeScreen(title: ""),
    );
  }
}
