import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/form_model.dart';

class CareGiverFormScreen extends StatefulWidget {
  final String userId;

  const CareGiverFormScreen({super.key, required this.userId});

  @override
  State<CareGiverFormScreen> createState() => _CareGiverFormScreenState();
}

class _CareGiverFormScreenState extends State<CareGiverFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController permanentAddressController = TextEditingController();
  final TextEditingController temporaryAddressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController previousExperienceController = TextEditingController();
  final TextEditingController strengthController = TextEditingController();
  final TextEditingController selfDevelopmentPlanController = TextEditingController();
  final TextEditingController caregiverPlanController = TextEditingController();

  String gender = 'Male';
  String education = 'Below 8';
  String areaOfInterest = 'ADLS';
  String preferredAgeGroup = 'Below 15 yrs';
  String preferredShift = 'Hourly basis';
  String paymentFrequency = 'Daily';

  bool workOnSundays = false;
  bool travelOutstation = false;
  bool willingToLearn = false;
  bool emergencySupport = false;

  List<String> workBasis = [];
  List<String> preferences = [];
  List<String> skills = [];
  List<String> languages = [];

  int currentPage = 0;

  Future<void> _selectDOB() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      CareGiverForm data = CareGiverForm(
        name: nameController.text,
        dob: dobController.text,
        gender: gender,
        permanentAddress: permanentAddressController.text,
        temporaryAddress: temporaryAddressController.text,
        mobile: mobileController.text,
        education: education,
        previousExperience: previousExperienceController.text,
        languages: languages,
        areaOfInterest: areaOfInterest,
        preferredAgeGroup: preferredAgeGroup,
        preferredShift: preferredShift,
        workOnSundays: workOnSundays,
        workBasis: workBasis,
        paymentFrequency: paymentFrequency,
        travelOutstation: travelOutstation,
        preferences: preferences,
        skills: skills,
        willingToLearn: willingToLearn,
        emergencySupport: emergencySupport,
        strength: strengthController.text,
        selfDevelopmentPlan: selfDevelopmentPlanController.text,
        caregiverPlan: caregiverPlanController.text,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('caregiver_forms')
          .doc(widget.userId)
          .set(data.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form submitted successfully!")),
      );
    }
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false, bool readOnly = false, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.all(16),
        ),
        validator: (value) => value == null || value.isEmpty ? "Please enter $label" : null,
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.all(12),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            isExpanded: true,
            value: value,
            onChanged: onChanged,
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(item.toString()),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildCheckboxList({
    required String title,
    required List<String> options,
    required List<String> selectedValues,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.separated(
                  itemCount: options.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final option = options[index];
                    final isSelected = selectedValues.contains(option);

                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        option,
                        style: TextStyle(
                          fontSize: 15,
                          color: isSelected ? Colors.black : Colors.grey[800],
                        ),
                      ),
                      value: isSelected,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedValues.add(option);
                          } else {
                            selectedValues.remove(option);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildNavigationButtons({bool showPrevious = true, bool showNext = true, bool showSubmit = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (showPrevious)
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_back),
            label: const Text("Previous"),
            onPressed: () {
              if (currentPage > 0) {
                setState(() => currentPage--);
                _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              }
            },
          ),
        if (showNext)
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Next"),
            onPressed: () {
              if (currentPage < 3) {
                setState(() => currentPage++);
                _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              }
            },
          ),
        if (showSubmit)
          ElevatedButton.icon(
            icon: const Icon(Icons.check),
            label: const Text("Submit"),
            onPressed: _submitForm,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // Page 1
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildTextField(nameController, "Name"),
                  _buildTextField(dobController, "Date of Birth", readOnly: true, onTap: _selectDOB),
                  _buildDropdown(label: "Gender", value: gender, items: ['Male', 'Female', 'Other'], onChanged: (val) => setState(() => gender = val!)),
                  _buildTextField(permanentAddressController, "Permanent Address"),
                  _buildTextField(temporaryAddressController, "Temporary Address"),
                  _buildTextField(mobileController, "Mobile Number"),
                  const SizedBox(height: 16),
                  _buildNavigationButtons(showPrevious: false),
                ],
              ),
            ),

            // Page 2
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildDropdown(label: "Education", value: education, items: ['Below 8', '8', '10', '12'], onChanged: (val) => setState(() => education = val!)),
                  _buildTextField(previousExperienceController, "Previous Experience"),
                  _buildDropdown(label: "Area of Interest", value: areaOfInterest, items: ['ADLS', 'Communication', 'Mobility/Transport', 'Leisure/recreation', 'Nursing/Medical services', 'Therapist', 'Vocational Training', 'Employment', 'All of the above'], onChanged: (val) => setState(() => areaOfInterest = val!)),
                  _buildDropdown(label: "Preferred Age Group", value: preferredAgeGroup, items: ['Below 15 yrs', '15-25', '26-40', '41-60', '60 and above'], onChanged: (val) => setState(() => preferredAgeGroup = val!)),
                  _buildDropdown(label: "Preferred Shift", value: preferredShift, items: ['Hourly basis', 'Weekly shift basis', 'Monthly shift basis'], onChanged: (val) => setState(() => preferredShift = val!)),
                  _buildDropdown(label: "Payment Frequency", value: paymentFrequency, items: ['Daily', 'Weekly', 'Monthly'], onChanged: (val) => setState(() => paymentFrequency = val!)),
                  const SizedBox(height: 16),
                  _buildNavigationButtons(),
                ],
              ),
            ),

            // Page 3
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildCheckboxList(title: "Work Basis", options: ['Hourly basis', 'Weekly shift basis', 'Monthly shift basis'], selectedValues: workBasis),
                  _buildCheckboxList(title: "Preferences", options: ['Work in home with pet', 'Stay alone with care seeker', 'Vegetarian', 'Non-vegetarian', 'Urban', 'Rural', 'Home setting', 'Outside home setting'], selectedValues: preferences),
                  _buildCheckboxList(title: "Skills", options: ['Banking', 'Computers', 'Mobile', 'Cooking', 'Driving', 'Therapies', 'Spl. School setup', 'Travelling', 'Reading', 'Writing', 'Licensed two-wheeler', 'Licensed four-wheeler'], selectedValues: skills),
                  _buildCheckboxList(title: "Languages", options: ['English', 'Hindi', 'Tamil', 'Telugu'], selectedValues: languages),
                  const SizedBox(height: 16),
                  _buildNavigationButtons(),
                ],
              ),
            ),

            // Page 4
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSwitchTile("Willing to Work on Sundays", workOnSundays, (val) => setState(() => workOnSundays = val)),
                  _buildSwitchTile("Willing to Travel Outstation", travelOutstation, (val) => setState(() => travelOutstation = val)),
                  _buildSwitchTile("Willing to Learn", willingToLearn, (val) => setState(() => willingToLearn = val)),
                  _buildSwitchTile("Provide Emergency Support", emergencySupport, (val) => setState(() => emergencySupport = val)),
                  _buildTextField(strengthController, "Strength"),
                  _buildTextField(selfDevelopmentPlanController, "Self Development Plan"),
                  _buildTextField(caregiverPlanController, "Caregiver Plan"),
                  const SizedBox(height: 16),
                  _buildNavigationButtons(showNext: false, showSubmit: true),
                  ElevatedButton(onPressed: _submitForm, child: const Text("Submit Form")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
