/// token : "QpwL5tke4Pnpja7X4"

class UserModel {
  UserModel({
      this.token,});
// server theke  JSON থেকে ডেটা মডেলে আনার জন্য
  // data astece .....
  ///  আর ম্যাপ থেকে মডেল বানানোর মেশিনের নামই হলো fromJson।
  UserModel.fromJson(Map<String,dynamic> json) {

    token = json['token'];
  }
  String? token;
// মডেল থেকে JSON এ নেওয়ার জন্য (সেভ করার সময় লাগবে)
  // data jacche

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }

}