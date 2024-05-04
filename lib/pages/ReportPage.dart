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

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? image_to_report;
  String? pic_uid;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: MaterialButton(
            color: Colors.blue,
            child:
              const Text(
                "Выбрать изображение из галереи",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                )
              ),
            onPressed: () async {
              _pickImageFromGallery();
              String? uid = await APIService.uploadImage(image_to_report!);
              setState(() {
                pic_uid = uid!;
              });
            },
          ),
        ),
        Center(
          child:
          FormHelper.submitButton(
            "Отправить мусор",
            () {
              if (validateAndSave()) {
                setState(() {
                  isAPICallProcess = true;
                });
              }
            }
          ),
        )
      ],
    );
  }

  Future _pickImageFromGallery() async {
    final returned_image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image_to_report = returned_image!.path;
    });
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