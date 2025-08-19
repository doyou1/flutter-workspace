class LoginUserModel {
  String? userId;
  String? userPassword;
  bool isSaveId;

  LoginUserModel({this.userId, this.userPassword, this.isSaveId = false});
}