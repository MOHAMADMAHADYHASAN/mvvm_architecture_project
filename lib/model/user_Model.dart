/// token : "QpwL5tke4Pnpja7X4"

class UserModel {
  String? token;
  UserModel({
    this.token,});
// server theke  JSON থেকে ডেটা মডেলে আনার জন্য
// data astece.....
  UserModel.fromJson(Map<String,dynamic> json) {

    token = json['token'];
  }
 // String? token;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }

}