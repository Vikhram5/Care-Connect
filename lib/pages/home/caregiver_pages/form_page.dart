import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'care_giver_form.dart';
import 'feed_form.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String _selectedForm = 'CareGiver';

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
                    value: 'CareGiver',
                    child: Text("CareGiver Form"),
                  ),
                  DropdownMenuItem(
                    value: 'Feed',
                    child: Text("Feed Form"),
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
          child: _selectedForm == 'CareGiver'
              ? CareGiverFormScreen(userId: userId)
              : FeedForm(userId: userId),
        ),
      ],
    );
  }
}
