import 'package:flutter/material.dart';
import 'careseeker_pages/home_page.dart';
import 'careseeker_pages/form_page.dart';
import 'careseeker_pages/profile_page.dart';

class CareSeekerHome extends StatefulWidget {
  const CareSeekerHome({super.key});

  @override
  State<CareSeekerHome> createState() => _CareSeekerHomeState();
}

class _CareSeekerHomeState extends State<CareSeekerHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    CareSeekerHomePage(),
    CareSeekerFormPage(),
    CareSeekerProfilePage(),
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Form'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CareSeeker Dashboard"),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _navItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
