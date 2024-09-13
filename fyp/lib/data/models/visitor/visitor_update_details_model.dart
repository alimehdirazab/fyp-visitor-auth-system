class VisitorUpdateDetailsModel {
  final String id;
  final String? name;
  final String? profilePic; // Updated to String
  final String? cnicFrontPic; // Updated to String
  final String? cnicBacPic; // Updated to String
  final String email;
  final bool emailVerified;
  final String? phone;
  final List<String> devices;
  final DateTime createdAt;
  final DateTime updatedAt;

  VisitorUpdateDetailsModel({
    required this.id,
    this.name,
    this.profilePic,
    this.cnicFrontPic,
    this.cnicBacPic,
    required this.email,
    required this.emailVerified,
    this.phone,
    required this.devices,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VisitorUpdateDetailsModel.fromJson(Map<String, dynamic> json) {
    return VisitorUpdateDetailsModel(
      id: json['id'],
      name: json['name'],
      profilePic: json['profilePic'], // Expecting a String now
      cnicFrontPic: json['cnicFrontPic'], // Expecting a String now
      cnicBacPic: json['cnicBacPic'], // Expecting a String now
      email: json['email'],
      emailVerified: json['emailVerified'],
      phone: json['phone'],

      devices: List<String>.from(json['devices']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profilePic': profilePic, // Return as String
      'cnicFrontPic': cnicFrontPic, // Return as String
      'cnicBacPic': cnicBacPic, // Return as String
      'email': email,
      'emailVerified': emailVerified,
      'phone': phone,

      'devices': devices,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
