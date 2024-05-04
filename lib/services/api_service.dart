import 'dart:convert';
import 'dart:io';

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

  static Future<String?> uploadImage(String path) async {
    var request = http.MultipartRequest('POST', Uri.http(Config.imageServerURL, Config.uploadImg));
    request.files.add(await http.MultipartFile.fromPath('file', path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String img_uid = await response.stream.bytesToString();
      return img_uid;
    }
    return null;
  }

  static Future<String?> downloadImage(String id) async {
    var url = Uri.http(Config.imageServerURL, Config.uploadImg + "/" + id);


    var file = new File(id + ".png");
    IOSink ios = file.openWrite(mode: FileMode.append);
    http.get(url).then((http.Response responce) {
      ios.add(responce.bodyBytes);
    }).whenComplete(() => ios.close());

    return null;
  }
}