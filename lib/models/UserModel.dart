class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? profilepic;

  UserModel({this.uid, this.fullname, this.email, this.profilepic});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["userName"];
    email = map["userEmail"];
    profilepic = map["profilePic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "userName": fullname,
      "userEmail": email,
      "profilePic": profilepic,
    };
  }
}
