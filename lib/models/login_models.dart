import 'dart:convert';

class LoginRequestModel {
  String? email;
  String? password;

  LoginRequestModel({this.email, this.password});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

LoginResponceModel loginResponceModel(String str) =>
  LoginResponceModel.fromJson(json.decode(str));

class LoginResponceModel {
  String? jwtToken;

  LoginResponceModel({this.jwtToken});

  LoginResponceModel.fromJson(Map<String, dynamic> json) {
    jwtToken = json['jwtToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwtToken'] = this.jwtToken;
    return data;
  }
}

