import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminFormPage extends StatefulWidget {
  const AdminFormPage({super.key});

  @override
  State<AdminFormPage> createState() => _AdminFormPageState();
}

class _AdminFormPageState extends State<AdminFormPage> {
  String? _selectedRole;
  String? _selectedUserId;
  String? _selectedForm;

  final List<String> roles = ['CareSeeker', 'CareGiver'];

  // Role-based form filtering
  final Map<String, List<String>> roleFormOptions = {
    'CareSeeker': ['Care Seeker Form', 'Care Giver Feedback'],
    'CareGiver': ['Care Giver Form','Care Seeker Feedback'],
  };

  // Fetch users based on selected role
  Future<List<QueryDocumentSnapshot>> _fetchUsersWithRole(String role) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: role)
        .get();

    return snapshot.docs;
  }

  // Map form label to Firestore collection
  String _getFormCollectionName(String formType) {
    switch (formType) {
      case 'Care Seeker Form':
        return 'careseeker_forms';
      case 'Care Giver Form':
        return 'caregiver_forms';
      case 'Care Seeker Feedback':
        return 'careseeker_feedback';
      case 'Care Giver Feedback':
        return 'care_giver_feedbacks';
      default:
        return '';
    }
  }

  // Role dropdown widget
  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: "Select Role",
        border: OutlineInputBorder(),
      ),
      value: _selectedRole,
      items: roles.map((role) {
        return DropdownMenuItem(
          value: role,
          child: Text(role),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedRole = value;
          _selectedUserId = null;
          _selectedForm = null;
        });
      },
    );
  }

  // User dropdown based on role
  Widget _buildUserDropdown(List<QueryDocumentSnapshot> users) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: "Select User",
        border: OutlineInputBorder(),
      ),
      value: _selectedUserId,
      items: users.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return DropdownMenuItem(
          value: doc.id,
          child: Text("${data['name'] ?? doc.id}"),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => _selectedUserId = value);
      },
    );
  }

  // Form dropdown based on role
  Widget _buildFormDropdown() {
    if (_selectedRole == null) return const SizedBox();

    final forms = roleFormOptions[_selectedRole!] ?? [];

    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: "Select Form Type",
        border: OutlineInputBorder(),
      ),
      value: _selectedForm,
      items: forms.map((form) {
        return DropdownMenuItem(
          value: form,
          child: Text(form),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => _selectedForm = value);
      },
    );
  }

  // Display user form entries
  Widget _buildFormList() {
    if (_selectedUserId == null || _selectedForm == null) {
      return const Center(child: Text("Please select a user and a form."));
    }

    final collectionName = _getFormCollectionName(_selectedForm!);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(_selectedUserId)
          .collection(collectionName)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No form submissions found."));
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final docId = docs[index].id;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                title: Text(
                  "📝 Form ID: $docId",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: data.entries.map((entry) {
                  return ListTile(
                    title: Text(
                      "${entry.key}:",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      entry.value.toString(),
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRoleDropdown(),
            const SizedBox(height: 12),
            if (_selectedRole != null)
              FutureBuilder<List<QueryDocumentSnapshot>>(
                future: _fetchUsersWithRole(_selectedRole!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No users found."));
                  }

                  return _buildUserDropdown(snapshot.data!);
                },
              ),
            const SizedBox(height: 12),
            if (_selectedUserId != null) _buildFormDropdown(),
            const SizedBox(height: 12),
            const Divider(thickness: 1),
            Expanded(child: _buildFormList()),
          ],
        ),
      ),
    );
  }
}
