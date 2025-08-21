import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../models/form_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send OTP
  Future<void> sendOtp(String phoneNumber, Function(String, int?) codeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        throw Exception(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // Verify OTP
  Future<UserCredential> verifyOtp(String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    return await _auth.signInWithCredential(credential);
  }

  // Save user data
  Future<void> saveUserData(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  // Get user data
  Future<UserModel?> getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // === FORMS STORED UNDER USER ===

  Future<void> createCareSeekerForm(String uid, CareSeekerForm form) async {
    await _firestore.collection('users').doc(uid).collection('care_seeker_forms').doc().set(form.toJson());
  }

  Future<List<CareSeekerForm>> getCareSeekerForms(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).collection('care_seeker_forms').get();
    return snapshot.docs.map((doc) => CareSeekerForm.fromJson(doc.data())).toList();
  }

  Future<void> updateCareSeekerForm(String uid, String formId, CareSeekerForm form) async {
    await _firestore.collection('users').doc(uid).collection('care_seeker_forms').doc(formId).update(form.toJson());
  }

  Future<void> deleteCareSeekerForm(String uid, String formId) async {
    await _firestore.collection('users').doc(uid).collection('care_seeker_forms').doc(formId).delete();
  }

  Future<void> createCareGiverForm(String uid, CareGiverForm form) async {
    await _firestore.collection('users').doc(uid).collection('care_giver_forms').doc().set(form.toJson());
  }

  Future<List<CareGiverForm>> getCareGiverForms(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).collection('care_giver_forms').get();
    return snapshot.docs.map((doc) => CareGiverForm.fromJson(doc.data())).toList();
  }

  Future<void> updateCareGiverForm(String uid, String formId, CareGiverForm form) async {
    await _firestore.collection('users').doc(uid).collection('care_giver_forms').doc(formId).update(form.toJson());
  }

  Future<void> deleteCareGiverForm(String uid, String formId) async {
    await _firestore.collection('users').doc(uid).collection('care_giver_forms').doc(formId).delete();
  }

  // === FEEDBACK STORED UNDER USER ===

  Future<void> createCareSeekerFeedback(String uid, CareSeekerFeedbackForm form) async {
    final docId = form.name ?? DateTime.now().millisecondsSinceEpoch.toString();
    await _firestore.collection('users').doc(uid).collection('care_seeker_feedbacks').doc(docId).set(form.toJson());
  }

  Future<List<CareSeekerFeedbackForm>> getCareSeekerFeedbacks(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).collection('care_seeker_feedbacks').get();
    return snapshot.docs.map((doc) => CareSeekerFeedbackForm.fromJson(doc.data())).toList();
  }

  Future<void> createCareGiverFeedback(String uid, CareGiverFeedbackForm form) async {
    final docId = form.name ?? DateTime.now().millisecondsSinceEpoch.toString();
    await _firestore.collection('users').doc(uid).collection('care_giver_feedbacks').doc(docId).set(form.toJson());
  }

  Future<List<CareGiverFeedbackForm>> getCareGiverFeedbacks(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).collection('care_giver_feedbacks').get();
    return snapshot.docs.map((doc) => CareGiverFeedbackForm.fromJson(doc.data())).toList();
  }
}
