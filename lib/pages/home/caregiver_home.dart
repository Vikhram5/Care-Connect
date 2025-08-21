import 'package:flutter/material.dart';
import 'caregiver_pages/home_page.dart';
import 'caregiver_pages/form_page.dart';
import 'caregiver_pages/profile_page.dart';

class CareGiverHome extends StatefulWidget {
  const CareGiverHome({super.key});

  @override
  State<CareGiverHome> createState() => _CareGiverHomeState();
}

class _CareGiverHomeState extends State<CareGiverHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    FormPage(),
    ProfilePage(),
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
        title: const Text("CareGiver Dashboard"),
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
