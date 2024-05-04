import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/login_models.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isKeyExists = await APICacheManager().isAPICacheKeyExist("jwtoken");

    return isKeyExists;
  }

  static Future<LoginResponceModel?> loginDetails() async {
    var isKeyExists = await APICacheManager().isAPICacheKeyExist("jwtoken");

    if (isKeyExists) {
      var cacheData = await APICacheManager().getCacheData("jwtoken");
      return loginResponceModel(cacheData.syncData);
    }
  }

  static Future<void> setLoginDetails(LoginResponceModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(key: "jwtoken", syncData: jsonEncode(model.toJson()));

    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("jwtoken");
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
}