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

class ReportPage extends StatefulWidget {

  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String? comment;
  String?city;
  String?district;
  final List<double> values = [ 1.0, 2.0, 3.0, 4.0, 5.0];
  int index = 0;
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
    return SingleChildScrollView(
        child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, bottom: 5, top: 10),
          child: Text("", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
        ),
        Center(
          child: MaterialButton(
            color: Colors.greenAccent,
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
        Padding(
          padding: const EdgeInsets.only(left: 25, bottom: 5, top: 10),
          child: Text("", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
        ),
        Center(
          child:
            FormHelper.inputFieldWidget(
            context,
            "Коммент",
            "Введите город",
            (onValidateVal) {
              if (onValidateVal.isEmpty())
                {
              return "Город не может быть пустым";//TODO: better check of email
              }
              else
                {
                  return true;
                }
            },
              (onSavedVal) {
              city = onSavedVal;
                   },
                    )
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
              "Введите район",
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
            )
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
              "Введите комментарий",
                  (onValidateVal) {
                return true;//TODO: better check of email
              },
                  (onSavedVal) {
                comment = onSavedVal;
              },
            )
        ),
      Center(
      child:Slider(
        value: index.toDouble(),
        min: 0,
        max: values.length - 1,
        divisions: values.length - 1,
        label: values[index].toString(),
        onChanged: (double value) {
          setState(() {
            index = value.toInt();
          });
        },
      ),
      ),
        Padding(
          padding: const EdgeInsets.only(left: 25, bottom: 5, top: 10),
          child: Text("", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
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
                   if (image_to_report!.isNotEmpty) {
                     APIService.sendImage(image_to_report!).then((responce){
                          if (responce!= null) {
                            pic_uid=responce.toString();
                            sendTrashModel model=sendTrashModel(comment:comment,city:city,district:district,image:pic_uid);
                              //APIService.sendTrash(model).then((responce){
                          }



                     });


                   }
                }
              }

          ),
        ),
    ]
    )
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