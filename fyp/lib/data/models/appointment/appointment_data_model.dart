class User {
  final String id;
  final String? name;
  final String? profilePic;
  final String? cnicFrontPic;
  final String? cnicBackPic; // Fixed typo
  final String email;
  final bool emailVerified;
  final String? username;
  final String? role;
  final List<String> devices;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    this.name,
    this.profilePic,
    this.cnicFrontPic,
    this.cnicBackPic,
    required this.email,
    required this.emailVerified,
    this.username,
    this.role,
    required this.devices,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      profilePic: json['profilePic'],
      cnicFrontPic: json['cnicFrontPic'],
      cnicBackPic: json['cnicBacPic'], // Fixed typo
      email: json['email'],
      emailVerified: json['emailVerified'],
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
      'profilePic': profilePic,
      'cnicFrontPic': cnicFrontPic,
      'cnicBackPic': cnicBackPic,
      'email': email,
      'emailVerified': emailVerified,
      'username': username,
      'role': role,
      'devices': devices,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Visitor {
  final String id;
  final String? name;
  final String? profilePic;
  final String? cnicFrontPic;
  final String? cnicBackPic; // Fixed typo
  final String email;
  final bool emailVerified;
  final String? phone;
  final List<String> devices;
  final DateTime createdAt;
  final DateTime updatedAt;

  Visitor({
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

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      id: json['id'],
      name: json['name'],
      profilePic: json['profilePic'],
      cnicFrontPic: json['cnicFrontPic'],
      cnicBackPic: json['cnicBacPic'], // Fixed typo
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
      'profilePic': profilePic,
      'cnicFrontPic': cnicFrontPic,
      'cnicBackPic': cnicBackPic,
      'email': email,
      'emailVerified': emailVerified,
      'phone': phone,
      'devices': devices,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class AppointmentDataModel {
  final String id;
  final DateTime scheduleTime;
  final DateTime scheduleDate;
  final String title;
  final String reason;
  final String userId;
  final String visitorId;
  final DateTime? meetingTime;
  final String status;
  final String? userRole;
  final String? qrToken;
  final List<dynamic> mapTrackings;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final Visitor visitor;

  AppointmentDataModel({
    required this.id,
    required this.scheduleTime,
    required this.scheduleDate,
    required this.title,
    required this.reason,
    required this.userId,
    required this.visitorId,
    this.meetingTime,
    required this.status,
    this.userRole,
    this.qrToken,
    required this.mapTrackings,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.visitor,
  });

  factory AppointmentDataModel.fromJson(Map<String, dynamic> json) {
    return AppointmentDataModel(
      id: json['id'],
      scheduleTime: DateTime.parse(json['scheduleTime']),
      scheduleDate: DateTime.parse(json['scheduleDate']),
      title: json['title'],
      reason: json['reason'],
      userId: json['userId'],
      visitorId: json['visitorId'],
      meetingTime: json['meetingTime'] != null
          ? DateTime.parse(json['meetingTime'])
          : null,
      status: json['status'],
      userRole: json['userRole'],
      qrToken: json['qrToken'],
      mapTrackings: json['mapTrackings'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: User.fromJson(json['user']),
      visitor: Visitor.fromJson(json['visitor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scheduleTime': scheduleTime.toIso8601String(),
      'scheduleDate': scheduleDate.toIso8601String(),
      'title': title,
      'reason': reason,
      'userId': userId,
      'visitorId': visitorId,
      'meetingTime': meetingTime?.toIso8601String(),
      'status': status,
      'userRole': userRole,
      'qrToken': qrToken,
      'mapTrackings': mapTrackings,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'user': user.toJson(),
      'visitor': visitor.toJson(),
    };
  }
}
