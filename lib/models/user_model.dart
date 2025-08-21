class UserModel {
  final String uid;
  final String role;
  final String phoneNumber;
  final String name;
  final String email;
  final String address;

  UserModel({
    required this.uid,
    required this.role,
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.address,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      role: data['role'],
      phoneNumber: data['phoneNumber'],
      name: data['name'],
      email: data['email'],
      address: data['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'role': role,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'address': address,
    };
  }
}
