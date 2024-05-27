class StaffModel {
  final int status;
  final String res;
  final String message;
  final StaffData data;

  StaffModel({
    required this.status,
    required this.res,
    required this.message,
    required this.data,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      status: json['status'],
      res: json['res'],
      message: json['message'],
      data: StaffData.fromJson(json['data']),
    );
  }
}

class StaffData {
  final String accessToken;
  final String refreshToken;
  final String id;
  final String? name;
  final String? profilePic;
  final String? cnicFrontPic;
  final String? cnicBackPic;
  final String email;
  final bool emailVerified;
  final String? username;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  StaffData({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    this.name,
    this.profilePic,
    this.cnicFrontPic,
    this.cnicBackPic,
    required this.email,
    required this.emailVerified,
    this.username,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StaffData.fromJson(Map<String, dynamic> json) {
    return StaffData(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      id: json['id'],
      name: json['name'],
      profilePic: json['profilePic'],
      cnicFrontPic: json['cnicFrontPic'],
      cnicBackPic: json['cnicBacPic'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      username: json['username'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
