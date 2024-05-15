class StaffDetailsModel {
  int? id;
  Null? name;
  Null? profilePic;
  String? email;
  bool? emailVerified;
  Null? username;
  String? role;

  StaffDetailsModel(
      {this.id,
      this.name,
      this.profilePic,
      this.email,
      this.emailVerified,
      this.username,
      this.role});

  StaffDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePic = json['profilePic'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    username = json['username'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profilePic'] = this.profilePic;
    data['email'] = this.email;
    data['emailVerified'] = this.emailVerified;
    data['username'] = this.username;
    data['role'] = this.role;
    return data;
  }
}
