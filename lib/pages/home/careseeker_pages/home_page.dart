import 'package:flutter/material.dart';

class CareSeekerHomePage extends StatelessWidget {
  const CareSeekerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Welcome to CareSeeker Home!",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
