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
      'Content-type': 'application/json'
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var responce = await client.post(url, headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (responce.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponceModel(responce.body));
      return true;
    }

    return false;
  }

  static Future<RegisterResponceModel> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json'
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var responce = await client.post(url, headers: requestHeaders, body: jsonEncode(model.toJson()));

    return registerResponceModel(responce.body);
  }
}