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
  final String? profilePic;
  final String? cnicFrontPic;
  final String? cnicBackPic;
  final String email;
  final bool emailVerified;
  final String? phone;
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory VisitorData.fromJson(Map<String, dynamic> json) {
    return VisitorData(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      id: json['id'],
      name: json['name'],
      profilePic: json['profilePic'],
      cnicFrontPic: json['cnicFrontPic'],
      cnicBackPic: json['cnicBackPic'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      phone: json['phone'],
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
      'profilePic': profilePic,
      'cnicFrontPic': cnicFrontPic,
      'cnicBackPic': cnicBackPic,
      'email': email,
      'emailVerified': emailVerified,
      'phone': phone,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
