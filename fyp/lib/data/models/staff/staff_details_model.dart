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
  final FileDetails? profilePic;
  final FileDetails? cnicFrontPic;
  final FileDetails? cnicBacPic;
  final String email;
  final bool emailVerified;
  final String? phone;
  final String? username;
  final String role;
  final List<String> devices;
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
    this.phone,
    this.username,
    required this.role,
    required this.devices,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StaffDetailsData.fromJson(Map<String, dynamic> json) {
    return StaffDetailsData(
      id: json['id'],
      name: json['name'],
      profilePic: json['profilePic'] != null
          ? FileDetails.fromJson(json['profilePic'])
          : null,
      cnicFrontPic: json['cnicFrontPic'] != null
          ? FileDetails.fromJson(json['cnicFrontPic'])
          : null,
      cnicBacPic: json['cnicBacPic'] != null
          ? FileDetails.fromJson(json['cnicBacPic'])
          : null,
      email: json['email'],
      emailVerified: json['emailVerified'],
      phone: json['phone'],
      username: json['username'],
      role: json['role'],
      devices: List<String>.from(json['devices']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profilePic': profilePic?.toJson(),
      'cnicFrontPic': cnicFrontPic?.toJson(),
      'cnicBacPic': cnicBacPic?.toJson(),
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

class FileDetails {
  final String fileUrl;
  final String fileName;

  FileDetails({
    required this.fileUrl,
    required this.fileName,
  });

  factory FileDetails.fromJson(Map<String, dynamic> json) {
    return FileDetails(
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
