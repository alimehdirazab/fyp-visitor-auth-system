class AppointmentDataModel {
  final String id;
  final DateTime scheduleTime;
  final DateTime scheduleDate;
  final String reason;
  final String userId;
  final String visitorId;
  final String? userRole;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppointmentDataModel({
    required this.id,
    required this.scheduleTime,
    required this.scheduleDate,
    required this.reason,
    required this.userId,
    required this.visitorId,
    this.userRole,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppointmentDataModel.fromJson(Map<String, dynamic> json) {
    return AppointmentDataModel(
      id: json['id'],
      scheduleTime: DateTime.parse(json['scheduleTime']),
      scheduleDate: DateTime.parse(json['scheduleDate']),
      reason: json['reason'],
      userId: json['userId'],
      visitorId: json['visitorId'],
      userRole: json['userRole'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scheduleTime': scheduleTime.toIso8601String(),
      'scheduleDate': scheduleDate.toIso8601String(),
      'reason': reason,
      'userId': userId,
      'visitorId': visitorId,
      'userRole': userRole,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
