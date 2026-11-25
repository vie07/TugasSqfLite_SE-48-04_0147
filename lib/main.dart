import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_sqf/app_binding.dart';
import 'package:tugas_sqf/presentation/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      home: const HomeScreen(),
    );
  }
}