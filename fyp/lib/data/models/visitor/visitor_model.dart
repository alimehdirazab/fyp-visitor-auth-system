class VisitorModel {
  final int status;
  final String res;
  final String message;
  final VisitorData data;

  VisitorModel({
    required this.status,
    required this.res,
    required this.message,
    required this.data,
  });

  factory VisitorModel.fromJson(Map<String, dynamic> json) {
    return VisitorModel(
      status: json['status'],
      res: json['res'],
      message: json['message'],
      data: VisitorData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'res': res,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class VisitorData {
  final String accessToken;
  final String refreshToken;
  final String id;
  final String? name;
  final String? profilePic; // Changed to String
  final String? cnicFrontPic; // Changed to String
  final String? cnicBackPic; // Changed to String and key updated
  final String email;
  final bool emailVerified;
  final String? phone;
  final List<String> devices;
  final DateTime createdAt;
  final DateTime updatedAt;

  VisitorData({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    this.name,
    this.profilePic,
    this.cnicFrontPic,
    this.cnicBackPic,
    required this.email,
    required this.emailVerified,
    this.phone,
    required this.devices,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VisitorData.fromJson(Map<String, dynamic> json) {
    return VisitorData(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      id: json['id'],
      name: json['name'],
      profilePic: json['profilePic'], // Updated
      cnicFrontPic: json['cnicFrontPic'], // Updated
      cnicBackPic: json['cnicBacPic'], // Updated key name
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
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'id': id,
      'name': name,
      'profilePic': profilePic, // Updated
      'cnicFrontPic': cnicFrontPic, // Updated
      'cnicBackPic': cnicBackPic, // Updated key name
      'email': email,
      'emailVerified': emailVerified,
      'phone': phone,
      'devices': devices,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
