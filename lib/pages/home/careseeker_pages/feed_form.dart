import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/form_model.dart';

class FeedForm extends StatefulWidget {
  final String userId;

  const FeedForm({super.key, required this.userId});

  @override
  State<FeedForm> createState() => _FeedFormState();
}

class _FeedFormState extends State<FeedForm> {
  String rating = 'Excellent';
  List<String> selectedIssues = [];
  final TextEditingController _nameController = TextEditingController();
  bool _isSubmitting = false;

  final List<String> issueOptions = [
    'Late Arrival',
    'Unprofessional Behavior',
    'Improper Communication',
    'Caregiver Unfit',
    'Others',
  ];

  void _submitFeedback() async {
    setState(() {
      _isSubmitting = true;
    });

    final feedback = CareGiverFeedbackForm(
      rating: rating,
      issues: selectedIssues,
      name: _nameController.text.isNotEmpty ? _nameController.text : null,
    );

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('care_seeker_feedbacks')
          .add(feedback.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback Submitted')),
      );

      // Reset form
      setState(() {
        rating = 'Excellent';
        selectedIssues.clear();
        _nameController.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Rate the service:", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: rating,
                isExpanded: true,
                items: ['Poor', 'Average', 'Excellent']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => rating = val);
                  }
                },
              ),
              const SizedBox(height: 24),
              const Text("Select any issues you faced:", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              ...issueOptions.map((issue) => CheckboxListTile(
                title: Text(issue),
                value: selectedIssues.contains(issue),
                onChanged: (val) {
                  setState(() {
                    val!
                        ? selectedIssues.add(issue)
                        : selectedIssues.remove(issue);
                  });
                },
              )),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Your Name (Optional)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitFeedback,
                  child: _isSubmitting
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text("Submit Feedback"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
