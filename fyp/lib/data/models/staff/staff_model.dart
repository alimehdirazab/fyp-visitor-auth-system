class StaffModel {
  int? status;
  String? res;
  String? message;
  StaffData? data;

  StaffModel({this.status, this.res, this.message, this.data});

  StaffModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    res = json['res'];
    message = json['message'];
    data = json['data'] != null ? StaffData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['res'] = this.res;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class StaffData {
  String? accessToken;
  String? refreshToken;
  int? id;
  String? name;
  String? profilePic;
  String? email;
  String? username;
  String? role;

  StaffData({
    this.accessToken,
    this.refreshToken,
    this.id,
    this.name,
    this.profilePic,
    this.email,
    this.username,
    this.role,
  });

  StaffData.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    id = json['id'];
    name = json['name'];
    profilePic = json['profilePic'];
    email = json['email'];
    username = json['username'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['id'] = this.id;
    data['name'] = this.name;
    data['profilePic'] = this.profilePic;
    data['email'] = this.email;
    data['username'] = this.username;
    data['role'] = this.role;
    return data;
  }
}
