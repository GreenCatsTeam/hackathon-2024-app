import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/models/login_models.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    print("ye1");
    print(APICacheManager() == null);
    // var isKeyExists = await APICacheManager().isAPICacheKeyExist("jwtoken");
    var isKeyExists = (yootoken == null);
    print("ye2");

    return isKeyExists;
  }

  static Future<LoginResponceModel?> loginDetails() async {
    // var isKeyExists = await APICacheManager().isAPICacheKeyExist("jwtoken");
    var isKeyExists = (yootoken == null);
    if (isKeyExists) {
      // var cacheData = await APICacheManager().getCacheData("jwtoken");

      return loginResponceModel(yootoken!);
    }
  }

  static Future<void> setLoginDetails(LoginResponceModel model) async {
    print("oi");
    // APICacheDBModel cacheDBModel = APICacheDBModel(key: "jwtoken", syncData: jsonEncode(model.toJson()));
    print("oi1");

    // await APICacheManager().addCacheData(cacheDBModel);
    print("oi2");
    yootoken = model.jwtToken;
  }

  static Future<void> logout(BuildContext context) async {
    // await APICacheManager().deleteCache("jwtoken");
    yootoken = null;
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
}