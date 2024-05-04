import 'dart:convert';

class RegisterRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? role;
  String? organization;
  String? city;
  String? district;

  RegisterRequestModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.role,
      this.organization,
      this.city,
      this.district});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    organization = json['organization'];
    city = json['city'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    data['organization'] = this.organization;
    data['cityName'] = this.city;
    data['districtName'] = this.district;
    return data;
  }
}

RegisterResponceModel registerResponceModel(String str) =>
  RegisterResponceModel.fromJson(json.decode(str));

class RegisterResponceModel {
  String? jwtToken;
  String? description;

  RegisterResponceModel({this.jwtToken, this.description});

  RegisterResponceModel.fromJson(Map<String, dynamic> json) {
    jwtToken = json['jwtToken'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwtToken'] = this.jwtToken;
    data['description'] = this.description;
    return data;
  }
}
