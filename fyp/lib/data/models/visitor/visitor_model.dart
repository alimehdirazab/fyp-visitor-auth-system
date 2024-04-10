class VisitorModel {
  int? status;
  String? res;
  String? message;
  VisitorData? data;

  VisitorModel({this.status, this.res, this.message, this.data});

  VisitorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    res = json['res'];
    message = json['message'];
    data = json['data'] != null ? new VisitorData.fromJson(json['data']) : null;
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

class VisitorData {
  String? accessToken;
  String? refreshToken;
  int? id;
  Null? name;
  Null? profilePic;
  String? email;
  bool? emailVerified;
  Null? phone;

  VisitorData(
      {this.accessToken,
      this.refreshToken,
      this.id,
      this.name,
      this.profilePic,
      this.email,
      this.emailVerified,
      this.phone});

  VisitorData.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    id = json['id'];
    name = json['name'];
    profilePic = json['profilePic'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['id'] = this.id;
    data['name'] = this.name;
    data['profilePic'] = this.profilePic;
    data['email'] = this.email;
    data['emailVerified'] = this.emailVerified;
    data['phone'] = this.phone;
    return data;
  }
}
