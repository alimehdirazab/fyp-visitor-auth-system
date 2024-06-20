class StaffDetailsModel {
  final int status;
  final String res;
  final String message;
  final List<StaffDetailsData> data;

  StaffDetailsModel({
    required this.status,
    required this.res,
    required this.message,
    required this.data,
  });

  factory StaffDetailsModel.fromJson(Map<String, dynamic> json) {
    return StaffDetailsModel(
      status: json['status'],
      res: json['res'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => StaffDetailsData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'res': res,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class StaffDetailsData {
  final String id;
  final String? name;
  final String? profilePic;
  final String? cnicFrontPic;
  final String? cnicBacPic;
  final String email;
  final bool emailVerified;
  final String? username;
  final String? role;
  final DateTime createdAt;
  final DateTime updatedAt;

  StaffDetailsData({
    required this.id,
    this.name,
    this.profilePic,
    this.cnicFrontPic,
    this.cnicBacPic,
    required this.email,
    required this.emailVerified,
    this.username,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StaffDetailsData.fromJson(Map<String, dynamic> json) {
    return StaffDetailsData(
      id: json['id'],
      name: json['name'],
      profilePic: json['profilePic'],
      cnicFrontPic: json['cnicFrontPic'],
      cnicBacPic: json['cnicBacPic'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      username: json['username'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profilePic': profilePic,
      'cnicFrontPic': cnicFrontPic,
      'cnicBacPic': cnicBacPic,
      'email': email,
      'emailVerified': emailVerified,
      'username': username,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
