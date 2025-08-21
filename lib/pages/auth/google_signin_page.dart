import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'user_details_form.dart';
import '../../pages/home/admin_home.dart';
import '../../pages/home/caregiver_home.dart';
import '../../pages/home/careseeker_home.dart';

class GoogleSignInPage extends StatefulWidget {
  final String selectedRole;
  const GoogleSignInPage({super.key, required this.selectedRole});

  @override
  State<GoogleSignInPage> createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  bool isLoading = false;

  void _signInWithGoogle() async {
    setState(() => isLoading = true);

    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // Step 1: Sign out from both Firebase and Google to clear previous session
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();

      // Step 2: Sign in with Google
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        setState(() => isLoading = false);
        return; // User canceled sign in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user!;

      // Step 3: Check Firestore for existing user document
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        _redirectToHome(userDoc['role']);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => UserDetailsForm(role: widget.selectedRole),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google sign-in failed: $e")),
      );
    }

    setState(() => isLoading = false);
  }

  void _redirectToHome(String role) {
    Widget home;
    switch (role) {
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

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => home),
    );
  }

  @override
  void initState() {
    super.initState();
    _signInWithGoogle(); // Auto start sign-in when page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text("Preparing sign-in..."),
      ),
    );
  }
}
