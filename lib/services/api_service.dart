import 'dart:convert';

import 'package:flutter_application_2/config.dart';
import 'package:flutter_application_2/models/login_models.dart';
import 'package:flutter_application_2/models/register_models.dart';
import 'package:flutter_application_2/services/shared_service.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Host': Config.apiURL
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    requestHeaders['Content-Length'] = jsonEncode(model.toJson()).length.toString();
    print(jsonEncode(model.toJson()));
    print(requestHeaders.toString());
    print(url);
    print("yay!");

    var responce = await client.post(url, headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (responce.statusCode == 200) {
      print("yay1!");
      print(responce.body);
      await SharedService.setLoginDetails(loginResponceModel(responce.body));
      print("yay2!");
      return true;
    }

    return false;
  }

  static Future<RegisterResponceModel> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Host': Config.apiURL
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    model.organization = "";

    requestHeaders['Content-Length'] = jsonEncode(model.toJson()).length.toString();
    print(jsonEncode(model.toJson()));
    print(requestHeaders.toString());
    print(url);
    print("yay!");
    var responce = await client.post(url, headers: requestHeaders, body: jsonEncode(model.toJson()));

    return registerResponceModel(responce.body);
  }
}