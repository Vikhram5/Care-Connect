import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/user_tile.dart';

class AdminUsersPage extends StatelessWidget {
  const AdminUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          final groupedUsers = <String, List<Map<String, dynamic>>>{};

          for (final doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;
            final role = data['role'] ?? 'Unknown';
            data['id'] = doc.id; // Add the document ID for uniqueness if needed
            groupedUsers.putIfAbsent(role, () => []).add(data);
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: groupedUsers.keys.length,
              itemBuilder: (context, index) {
                final role = groupedUsers.keys.elementAt(index);
                final users = groupedUsers[role]!;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  shadowColor: Colors.black.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.all(12),
                    title: Row(
                      children: [
                        Icon(
                          role == 'Admin'
                              ? Icons.admin_panel_settings
                              : Icons.person,
                          color: role == 'Admin' ? Colors.blue : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "$role (${users.length})",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    childrenPadding: const EdgeInsets.only(bottom: 8.0),
                    children: users.map((user) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              user['name']?.substring(0, 1) ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            user['name'] ?? 'Unknown User',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            user['email'] ?? 'No Email',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blueAccent,
                          ),
                          onTap: () {
                            // Add any navigation or action you want here
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Custom Search Delegate for the search bar
class UserSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Search Users...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filter the results based on the query entered
    final results = FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: results,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No users found.'));
        }

        final users = snapshot.data!.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();

        return ListView(
          children: users.map((user) {
            return ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  user['name']?.substring(0, 1) ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(user['name'] ?? 'Unknown User'),
              subtitle: Text(user['email'] ?? 'No Email'),
              onTap: () {
                // Navigate to a user detail page or perform an action
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
