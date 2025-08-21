import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'care_seeker_form.dart';
import 'feed_form.dart';

class CareSeekerFormPage extends StatefulWidget {
  const CareSeekerFormPage({super.key});

  @override
  State<CareSeekerFormPage> createState() => _CareSeekerFormPageState();
}

class _CareSeekerFormPageState extends State<CareSeekerFormPage> {
  String _selectedForm = 'Request';

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const Icon(Icons.swap_horiz, color: Colors.blue),
              const SizedBox(width: 10),
              const Text(
                "Select Form: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: _selectedForm,
                items: const [
                  DropdownMenuItem(
                    value: 'Request',
                    child: Text("Request Form"),
                  ),
                  DropdownMenuItem(
                    value: 'Feedback',
                    child: Text("Feedback Form"),
                  ),
                ],
                onChanged: (value) {
                  setState(() => _selectedForm = value!);
                },
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: _selectedForm == 'Request'
              ? CareSeekerForm(userId: userId)
              : FeedForm(userId: userId),
        ),
      ],
    );
  }
}
