import 'package:flutter/material.dart';

class CareSeekerForm extends StatefulWidget {
  final String userId;
  const CareSeekerForm({super.key, required this.userId});

  @override
  State<CareSeekerForm> createState() => _CareSeekerFormState();
}

class _CareSeekerFormState extends State<CareSeekerForm> {
  final _formKey = GlobalKey<FormState>();

  // Basic Fields
  final _filledByController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _disabilityTypeController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _occupationController = TextEditingController();

  final _familyMembersController = TextEditingController();
  final _maleMembersController = TextEditingController();
  final _femaleMembersController = TextEditingController();

  bool _hasPets = false;
  final _petDetailsController = TextEditingController();

  // Daily Care
  final _foodHabitsController = TextEditingController();
  final _brushingController = TextEditingController();
  final _bathingController = TextEditingController();
  final _toiletingController = TextEditingController();
  final _eatingController = TextEditingController();
  final _groomingController = TextEditingController();

  // Communication
  final List<String> _communicationLanguages = [];
  final List<String> _communicationModes = [];
  final _communicationDevicesController = TextEditingController();

  // Mobility
  final _mobilityController = TextEditingController();
  final _transportController = TextEditingController();

  // Leisure
  final List<String> _leisureActivities = [];
  bool _supportForLeisure = false;

  // Assistive
  final List<String> _assistiveDevices = [];
  bool _assistiveSupport = false;

  // Others
  final _caregiverLeisureRequirementController = TextEditingController();
  final Map<String, bool> _medicalNeeds = {};
  final Map<String, bool> _therapySupport = {};
  bool _vocationalSupport = false;
  final List<String> _extraTasks = [];
  final _caregiverGenderPreferenceController = TextEditingController();
  final Map<String, String> _accessibility = {};

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'filledBy': _filledByController.text,
        'name': _nameController.text,
        'age': int.tryParse(_ageController.text) ?? 0,
        'gender': _genderController.text,
        'disabilityType': _disabilityTypeController.text,
        'address': _addressController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'occupation': _occupationController.text,
        'familyMembers': int.tryParse(_familyMembersController.text) ?? 0,
        'maleMembers': int.tryParse(_maleMembersController.text) ?? 0,
        'femaleMembers': int.tryParse(_femaleMembersController.text) ?? 0,
        'hasPets': _hasPets,
        'petDetails': _petDetailsController.text,
        'foodHabits': _foodHabitsController.text,
        'brushing': _brushingController.text,
        'bathing': _bathingController.text,
        'toileting': _toiletingController.text,
        'eating': _eatingController.text,
        'grooming': _groomingController.text,
        'communicationLanguages': _communicationLanguages,
        'communicationModes': _communicationModes,
        'communicationDevices': _communicationDevicesController.text,
        'mobility': _mobilityController.text,
        'transport': _transportController.text,
        'leisureActivities': _leisureActivities,
        'supportForLeisure': _supportForLeisure,
        'assistiveDevices': _assistiveDevices,
        'assistiveSupport': _assistiveSupport,
        'caregiverLeisureRequirement':
        _caregiverLeisureRequirementController.text,
        'medicalNeeds': _medicalNeeds,
        'therapySupport': _therapySupport,
        'vocationalSupport': _vocationalSupport,
        'extraTasks': _extraTasks,
        'caregiverGenderPreference':
        _caregiverGenderPreferenceController.text,
        'accessibility': _accessibility,
      };

      print("Submitting: $data");
      // Here you'd send it to Firebase or some backend.
    }
  }

  @override
  void dispose() {
    _filledByController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _disabilityTypeController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _occupationController.dispose();
    _familyMembersController.dispose();
    _maleMembersController.dispose();
    _femaleMembersController.dispose();
    _petDetailsController.dispose();
    _foodHabitsController.dispose();
    _brushingController.dispose();
    _bathingController.dispose();
    _toiletingController.dispose();
    _eatingController.dispose();
    _groomingController.dispose();
    _communicationDevicesController.dispose();
    _mobilityController.dispose();
    _transportController.dispose();
    _caregiverLeisureRequirementController.dispose();
    _caregiverGenderPreferenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text("Care Seeker Request Form",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextFormField(
            controller: _filledByController,
            decoration: const InputDecoration(labelText: "Filled By"),
            validator: (value) =>
            value!.isEmpty ? "Please enter filled by" : null,
          ),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name"),
            validator: (value) =>
            value!.isEmpty ? "Please enter name" : null,
          ),
          TextFormField(
            controller: _ageController,
            decoration: const InputDecoration(labelText: "Age"),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _genderController,
            decoration: const InputDecoration(labelText: "Gender"),
          ),
          TextFormField(
            controller: _disabilityTypeController,
            decoration: const InputDecoration(labelText: "Disability Type"),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: const Text("Submit"),
            onPressed: _submitForm,
          )
        ],
      ),
    );
  }
}
