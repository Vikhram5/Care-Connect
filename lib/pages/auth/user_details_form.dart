import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/admin_home.dart';
import '../home/caregiver_home.dart';
import '../home/careseeker_home.dart';

class UserDetailsForm extends StatefulWidget {
  final String role;
  const UserDetailsForm({super.key, required this.role});

  @override
  State<UserDetailsForm> createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  bool isLoading = false;

  void _submitDetails() async {
    if (nameController.text.isEmpty || ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() => isLoading = true);

    final user = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'name': nameController.text,
      'email': user.email,
      'age': ageController.text,
      'role': widget.role,
      'createdAt': Timestamp.now(),
    });

    Widget home;
    switch (widget.role) {
      case 'Admin':
        home = const AdminHome();
        break;
      case 'CareGiver':
        home = const CareGiverHome();
        break;
      case 'CareSeeker':
        home = const CareSeekerHome();
        break;
      default:
        home = const CareSeekerHome();
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => home));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(title: const Text("Complete Profile")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Just one step away!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Full Name"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Age"),
                ),
                const SizedBox(height: 30),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(
                  onPressed: _submitDetails,
                  icon: const Icon(Icons.check),
                  label: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
