import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/config.dart';
import 'package:flutter_application_2/models/login_models.dart';
import 'package:flutter_application_2/services/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:flutter_application_2/models/sendtrash_models.dart';

class UserInfoPage extends StatefulWidget {

  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {


  String?firstname="Петр";
  String?lastname="Петрович";
  String?role="user";
  String?org="";
  String?city="Саратов";
  String?district="Кировский";

  final List<double> values = [ 1.0, 2.0, 3.0, 4.0, 5.0];
  int index = 0;
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: HexColor("#283B71"),
        backgroundColor: Colors.greenAccent,
        body: ProgressHUD(
          child: Form(
              key: globalFormKey,
              child: _responceUI(context)
          ),
          key: UniqueKey(),
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,

        ),


      ),
    );
  }

  Widget _responceUI(BuildContext context) {
    return SingleChildScrollView(
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 5, top: 10),
                child: Text("", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
              ),

              Center(
                  child:
                  FormHelper.inputFieldWidget(
                    context,
                    "",
                    "$firstname",
                        (onValidateVal) {
                      if (onValidateVal.isEmpty())
                      {
                        return "Имя не может быть изменено на пустое";//TODO: better check of email
                      }
                    },
                        (onSavedVal) {
                      firstname = onSavedVal;
                    },
                    borderColor: Colors.indigo,
                    textColor: Colors.indigo,
                  )
              ),
              Center(
                child: MaterialButton(
                  color: Colors.greenAccent,
                  child:
                  const Text(
                      "Изменить  имя",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      )
                  ),
                  onPressed: () async {
                    isAPICallProcess=true;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 5, top: 10),
                child: Text("", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
              ),
              Center(
                  child:
                  FormHelper.inputFieldWidget(
                    context,
                    "",
                    "$lastname",
                        (onValidateVal) {
                          if (onValidateVal.isEmpty())
                          {
                            return "Отчество не может быть изменено на пустое";//TODO: better check of email
                          }
                    },
                        (onSavedVal) {
                      lastname = onSavedVal;
                    },
                    borderColor: Colors.indigo,
                    textColor: Colors.indigo,
                  )

              ),

              Center(
                child: MaterialButton(
                  color: Colors.greenAccent,
                  child:
                  const Text(
                      "Изменить отчество",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      )
                  ),
                  onPressed: () async {
                    isAPICallProcess=true;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 5, top: 10),
                child: Text("", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
              ),
              Center(
                  child:
                  FormHelper.inputFieldWidget(
                    context,
                    "Коммент",
                    "$district",
                        (onValidateVal) {
                      if (onValidateVal.isEmpty())
                      {
                        return "Район не может быть пустым";//TODO: better check of email
                      }
                      else
                      {
                        return true;
                      }
                    },
                        (onSavedVal) {
                      district = onSavedVal;
                    },
                    borderColor: Colors.indigo,
                    textColor: Colors.indigo,
                  )
              ),

              Center(
                child: MaterialButton(
                  color: Colors.greenAccent,
                  child:
                  const Text(
                      "Изменить район",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      )
                  ),
                  onPressed: () async {
                    isAPICallProcess=true;
                  },

                ),

              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 5, top: 10),
                child: Text("", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
              ),
              Center(
                  child:
                  FormHelper.inputFieldWidget(
                    context,
                    "Коммент",
                    "$city",
                        (onValidateVal) {
                      if (onValidateVal.isEmpty())
                      {
                        return "Район не может быть пустым";//TODO: better check of email
                      }
                      else
                      {
                        return true;
                      }
                    },
                        (onSavedVal) {
                      district = onSavedVal;
                    },
                    borderColor: Colors.indigo,
                    textColor: Colors.indigo,
                  )
              ),
              Center(
                child: MaterialButton(
                  color: Colors.greenAccent,
                  child:
                  const Text(
                      "Изменить город",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      )
                  ),
                  onPressed: () async {
                    isAPICallProcess=true;
                  },
                ),
              ),

            ]
        )
    );
  }




  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}