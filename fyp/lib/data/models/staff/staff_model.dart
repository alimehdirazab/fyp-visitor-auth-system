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

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'res': res,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class StaffData {
  final String accessToken;
  final String refreshToken;
  final String id;
  final String? name;
  final PictureData? profilePic;
  final PictureData? cnicFrontPic;
  final PictureData? cnicBackPic; // Updated to match response
  final String email;
  final bool emailVerified;
  final String? phone;
  final String? username;
  final String? role; // Updated to handle potential null values
  final List<String> devices;
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
    this.phone,
    this.username,
    this.role,
    required this.devices,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StaffData.fromJson(Map<String, dynamic> json) {
    return StaffData(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      id: json['id'],
      name: json['name'],
      profilePic: json['profilePic'] != null
          ? PictureData.fromJson(json['profilePic'])
          : null,
      cnicFrontPic: json['cnicFrontPic'] != null
          ? PictureData.fromJson(json['cnicFrontPic'])
          : null,
      cnicBackPic: json['cnicBackPic'] != null
          ? PictureData.fromJson(
              json['cnicBackPic']) // Updated to match response
          : null,
      email: json['email'],
      emailVerified: json['emailVerified'],
      phone: json['phone'],
      username: json['username'],
      role: json['role'], // Updated to handle potential null values
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
      'profilePic': profilePic?.toJson(),
      'cnicFrontPic': cnicFrontPic?.toJson(),
      'cnicBackPic': cnicBackPic?.toJson(),
      'email': email,
      'emailVerified': emailVerified,
      'phone': phone,
      'username': username,
      'role': role,
      'devices': devices,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class PictureData {
  final String? fileUrl;
  final String? fileName;

  PictureData({
    this.fileUrl,
    this.fileName,
  });

  factory PictureData.fromJson(Map<String, dynamic> json) {
    return PictureData(
      fileUrl: json['fileUrl'],
      fileName: json['fileName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileUrl': fileUrl,
      'fileName': fileName,
    };
  }
}
