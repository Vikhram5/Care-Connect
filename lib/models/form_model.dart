/// ------------------------------------
/// CARE SEEKER FORM
/// ------------------------------------
class CareSeekerForm {
  String filledBy;
  String name;
  int age;
  String gender;
  String disabilityType;
  String address;
  String phone;
  String email;
  String occupation;
  int familyMembers;
  int maleMembers;
  int femaleMembers;
  bool hasPets;
  String? petDetails;
  String foodHabits;

  String brushing;
  String bathing;
  String toileting;
  String eating;
  String grooming;

  List<String> communicationLanguages;
  List<String> communicationModes;
  String communicationDevices;

  String mobility;
  String transport;

  List<String> leisureActivities;
  bool supportForLeisure;
  List<String> assistiveDevices;
  bool assistiveSupport;
  String caregiverLeisureRequirement;

  Map<String, bool> medicalNeeds;
  Map<String, bool> therapySupport;

  bool vocationalSupport;
  List<String> extraTasks;

  String caregiverGenderPreference;
  Map<String, String> accessibility;

  CareSeekerForm({
    required this.filledBy,
    required this.name,
    required this.age,
    required this.gender,
    required this.disabilityType,
    required this.address,
    required this.phone,
    required this.email,
    required this.occupation,
    required this.familyMembers,
    required this.maleMembers,
    required this.femaleMembers,
    required this.hasPets,
    this.petDetails,
    required this.foodHabits,
    required this.brushing,
    required this.bathing,
    required this.toileting,
    required this.eating,
    required this.grooming,
    required this.communicationLanguages,
    required this.communicationModes,
    required this.communicationDevices,
    required this.mobility,
    required this.transport,
    required this.leisureActivities,
    required this.supportForLeisure,
    required this.assistiveDevices,
    required this.assistiveSupport,
    required this.caregiverLeisureRequirement,
    required this.medicalNeeds,
    required this.therapySupport,
    required this.vocationalSupport,
    required this.extraTasks,
    required this.caregiverGenderPreference,
    required this.accessibility,
  });

  Map<String, dynamic> toJson() => {
    'filledBy': filledBy,
    'name': name,
    'age': age,
    'gender': gender,
    'disabilityType': disabilityType,
    'address': address,
    'phone': phone,
    'email': email,
    'occupation': occupation,
    'familyMembers': familyMembers,
    'maleMembers': maleMembers,
    'femaleMembers': femaleMembers,
    'hasPets': hasPets,
    'petDetails': petDetails,
    'foodHabits': foodHabits,
    'brushing': brushing,
    'bathing': bathing,
    'toileting': toileting,
    'eating': eating,
    'grooming': grooming,
    'communicationLanguages': communicationLanguages,
    'communicationModes': communicationModes,
    'communicationDevices': communicationDevices,
    'mobility': mobility,
    'transport': transport,
    'leisureActivities': leisureActivities,
    'supportForLeisure': supportForLeisure,
    'assistiveDevices': assistiveDevices,
    'assistiveSupport': assistiveSupport,
    'caregiverLeisureRequirement': caregiverLeisureRequirement,
    'medicalNeeds': medicalNeeds,
    'therapySupport': therapySupport,
    'vocationalSupport': vocationalSupport,
    'extraTasks': extraTasks,
    'caregiverGenderPreference': caregiverGenderPreference,
    'accessibility': accessibility,
  };

  factory CareSeekerForm.fromJson(Map<String, dynamic> json) => CareSeekerForm(
    filledBy: json['filledBy'] ?? '',
    name: json['name'] ?? '',
    age: json['age'] ?? 0,
    gender: json['gender'] ?? '',
    disabilityType: json['disabilityType'] ?? '',
    address: json['address'] ?? '',
    phone: json['phone'] ?? '',
    email: json['email'] ?? '',
    occupation: json['occupation'] ?? '',
    familyMembers: json['familyMembers'] ?? 0,
    maleMembers: json['maleMembers'] ?? 0,
    femaleMembers: json['femaleMembers'] ?? 0,
    hasPets: json['hasPets'] ?? false,
    petDetails: json['petDetails'],
    foodHabits: json['foodHabits'] ?? '',
    brushing: json['brushing'] ?? '',
    bathing: json['bathing'] ?? '',
    toileting: json['toileting'] ?? '',
    eating: json['eating'] ?? '',
    grooming: json['grooming'] ?? '',
    communicationLanguages:
    List<String>.from(json['communicationLanguages'] ?? []),
    communicationModes: List<String>.from(json['communicationModes'] ?? []),
    communicationDevices: json['communicationDevices'] ?? '',
    mobility: json['mobility'] ?? '',
    transport: json['transport'] ?? '',
    leisureActivities: List<String>.from(json['leisureActivities'] ?? []),
    supportForLeisure: json['supportForLeisure'] ?? false,
    assistiveDevices: List<String>.from(json['assistiveDevices'] ?? []),
    assistiveSupport: json['assistiveSupport'] ?? false,
    caregiverLeisureRequirement: json['caregiverLeisureRequirement'] ?? '',
    medicalNeeds: Map<String, bool>.from(json['medicalNeeds'] ?? {}),
    therapySupport: Map<String, bool>.from(json['therapySupport'] ?? {}),
    vocationalSupport: json['vocationalSupport'] ?? false,
    extraTasks: List<String>.from(json['extraTasks'] ?? []),
    caregiverGenderPreference: json['caregiverGenderPreference'] ?? '',
    accessibility: Map<String, String>.from(json['accessibility'] ?? {}),
  );
}

/// ------------------------------------
/// CARE GIVER FORM
/// ------------------------------------
class CareGiverForm {
  String name;
  String dob;
  String gender;
  String permanentAddress;
  String temporaryAddress;
  String mobile;
  String education;
  String previousExperience;
  List<String> languages;
  String areaOfInterest;
  String preferredAgeGroup;
  String preferredShift;
  bool workOnSundays;
  List<String> workBasis;
  String paymentFrequency;
  bool travelOutstation;
  List<String> preferences;
  List<String> skills;
  bool willingToLearn;
  bool emergencySupport;
  String strength;
  String selfDevelopmentPlan;
  String caregiverPlan;

  CareGiverForm({
    required this.name,
    required this.dob,
    required this.gender,
    required this.permanentAddress,
    required this.temporaryAddress,
    required this.mobile,
    required this.education,
    required this.previousExperience,
    required this.languages,
    required this.areaOfInterest,
    required this.preferredAgeGroup,
    required this.preferredShift,
    required this.workOnSundays,
    required this.workBasis,
    required this.paymentFrequency,
    required this.travelOutstation,
    required this.preferences,
    required this.skills,
    required this.willingToLearn,
    required this.emergencySupport,
    required this.strength,
    required this.selfDevelopmentPlan,
    required this.caregiverPlan,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'dob': dob,
    'gender': gender,
    'permanentAddress': permanentAddress,
    'temporaryAddress': temporaryAddress,
    'mobile': mobile,
    'education': education,
    'previousExperience': previousExperience,
    'languages': languages,
    'areaOfInterest': areaOfInterest,
    'preferredAgeGroup': preferredAgeGroup,
    'preferredShift': preferredShift,
    'workOnSundays': workOnSundays,
    'workBasis': workBasis,
    'paymentFrequency': paymentFrequency,
    'travelOutstation': travelOutstation,
    'preferences': preferences,
    'skills': skills,
    'willingToLearn': willingToLearn,
    'emergencySupport': emergencySupport,
    'strength': strength,
    'selfDevelopmentPlan': selfDevelopmentPlan,
    'caregiverPlan': caregiverPlan,
  };

  factory CareGiverForm.fromJson(Map<String, dynamic> json) => CareGiverForm(
    name: json['name'] ?? '',
    dob: json['dob'] ?? '',
    gender: json['gender'] ?? '',
    permanentAddress: json['permanentAddress'] ?? '',
    temporaryAddress: json['temporaryAddress'] ?? '',
    mobile: json['mobile'] ?? '',
    education: json['education'] ?? '',
    previousExperience: json['previousExperience'] ?? '',
    languages: List<String>.from(json['languages'] ?? []),
    areaOfInterest: json['areaOfInterest'] ?? '',
    preferredAgeGroup: json['preferredAgeGroup'] ?? '',
    preferredShift: json['preferredShift'] ?? '',
    workOnSundays: json['workOnSundays'] ?? false,
    workBasis: List<String>.from(json['workBasis'] ?? []),
    paymentFrequency: json['paymentFrequency'] ?? '',
    travelOutstation: json['travelOutstation'] ?? false,
    preferences: List<String>.from(json['preferences'] ?? []),
    skills: List<String>.from(json['skills'] ?? []),
    willingToLearn: json['willingToLearn'] ?? false,
    emergencySupport: json['emergencySupport'] ?? false,
    strength: json['strength'] ?? '',
    selfDevelopmentPlan: json['selfDevelopmentPlan'] ?? '',
    caregiverPlan: json['caregiverPlan'] ?? '',
  );
}

/// ------------------------------------
/// FEEDBACK FORM - CARE GIVER
/// ------------------------------------
class CareGiverFeedbackForm {
  String rating; // e.g., "Poor", "Average", "Excellent"
  List<String> issues; // multiple checkboxes
  String? name;

  CareGiverFeedbackForm({
    required this.rating,
    required this.issues,
    this.name,
  });

  Map<String, dynamic> toJson() => {
    'rating': rating,
    'issues': issues,
    'name': name,
  };

  factory CareGiverFeedbackForm.fromJson(Map<String, dynamic> json) =>
      CareGiverFeedbackForm(
        rating: json['rating'] ?? '',
        issues: List<String>.from(json['issues'] ?? []),
        name: json['name'],
      );
}

/// ------------------------------------
/// FEEDBACK FORM - CARE SEEKER
/// ------------------------------------
class CareSeekerFeedbackForm {
  String rating;
  List<String> issues;
  String? name;

  CareSeekerFeedbackForm({
    required this.rating,
    required this.issues,
    this.name,
  });

  Map<String, dynamic> toJson() => {
    'rating': rating,
    'issues': issues,
    'name': name,
  };

  factory CareSeekerFeedbackForm.fromJson(Map<String, dynamic> json) =>
      CareSeekerFeedbackForm(
        rating: json['rating'] ?? '',
        issues: List<String>.from(json['issues'] ?? []),
        name: json['name'],
      );
}
