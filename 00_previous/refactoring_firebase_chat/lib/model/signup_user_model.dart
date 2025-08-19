import 'dart:io';

class SignupUserModel {
  String? userId;
  String? userPassword;
  String? userName;
  File? userPickedImage;

  SignupUserModel({this.userId, this.userPassword, this.userName, this.userPickedImage});
}