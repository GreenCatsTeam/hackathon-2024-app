import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/config.dart';
import 'package:flutter_application_2/models/register_models.dart';
import 'package:flutter_application_2/services/api_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;
  String? firstname;
  String? lastname;
  String? city;
  String? district;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: HexColor("#283B71"),
        backgroundColor: Colors.greenAccent,
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _registerUI(context)
          ),
        key: UniqueKey(),
        inAsyncCall: isAPICallProcess,
        opacity: 0.3,
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height /4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ] 
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100)
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/kitty.jpg",
                    height: MediaQuery.of(context).size.height /4,
                    fit: BoxFit.contain
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              top: 20
            ),
            child: Center(
              child: Text(
                "Регистрация",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.indigo,
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 5),
            child: Text("Почта", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
          ),
          FormHelper.inputFieldWidget(
            context,
            "Почта",
            "example@mail.ru",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Почта не должна быть пустой"; //TODO: better check of email
              }
              return null;
            },
            (onSavedVal) {
              username = onSavedVal;
            },
            prefixIcon: const Icon(Icons.mail),
            borderFocusColor: Colors.indigoAccent,
            prefixIconColor: Colors.indigo,
            borderColor: Colors.indigo,
            textColor: Colors.indigo,
            hintColor: Colors.indigo.withOpacity(0.7),
            borderRadius: 20,
            showPrefixIcon: true
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 5, top: 10),
            child: Text("Пароль", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
          ),
          FormHelper.inputFieldWidget(
            context,
            "Пароль",
            "1234",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Пароль не должен быть пустым";
              }
              return null;
            },
            (onSavedVal) {
              username = onSavedVal;
            },
            prefixIcon: const Icon(Icons.password),
            borderFocusColor: Colors.indigoAccent,
            prefixIconColor: Colors.indigo,
            borderColor: Colors.indigo,
            textColor: Colors.indigo,
            hintColor: Colors.indigo.withOpacity(0.7),
            borderRadius: 20,
            showPrefixIcon: true,
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.indigo.withOpacity(0.7),
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility
              )
              )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 5, top: 10),
            child: Text("Фамилия", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
          ),
          FormHelper.inputFieldWidget(
            context,
            "Фамилия",
            "Иванов",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Фамилия не должна быть пустой";
              }
              return null;
            },
            (onSavedVal) {
              lastname = onSavedVal;
            },
            prefixIcon: const Icon(Icons.person),
            borderFocusColor: Colors.indigoAccent,
            prefixIconColor: Colors.indigo,
            borderColor: Colors.indigo,
            textColor: Colors.indigo,
            hintColor: Colors.indigo.withOpacity(0.7),
            borderRadius: 20,
            showPrefixIcon: true,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 5, top: 10),
            child: Text("Имя", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
          ),
          FormHelper.inputFieldWidget(
            context,
            "Имя",
            "Иван",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Имя не должно быть пустым";
              }
              return null;
            },
            (onSavedVal) {
              firstname = onSavedVal;
            },
            prefixIcon: const Icon(Icons.person_2),
            borderFocusColor: Colors.indigoAccent,
            prefixIconColor: Colors.indigo,
            borderColor: Colors.indigo,
            textColor: Colors.indigo,
            hintColor: Colors.indigo.withOpacity(0.7),
            borderRadius: 20,
            showPrefixIcon: true,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 5, top: 10),
            child: Text("Город", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
          ),
          FormHelper.inputFieldWidget(
            context,
            "Город",
            "Саратов",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Город не должен быть пустым";
              }
              return null;
            },
            (onSavedVal) {
              city = onSavedVal;
            },
            prefixIcon: const Icon(Icons.location_city),
            borderFocusColor: Colors.indigoAccent,
            prefixIconColor: Colors.indigo,
            borderColor: Colors.indigo,
            textColor: Colors.indigo,
            hintColor: Colors.indigo.withOpacity(0.7),
            borderRadius: 20,
            showPrefixIcon: true,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 5, top: 10),
            child: Text("Район", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo)),
          ),
          FormHelper.inputFieldWidget(
            context,
            "Район",
            "Кировский",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Район не должен быть пустым";
              }
              return null;
            },
            (onSavedVal) {
              district = onSavedVal;
            },
            prefixIcon: const Icon(Icons.zoom_in),
            borderFocusColor: Colors.indigoAccent,
            prefixIconColor: Colors.indigo,
            borderColor: Colors.indigo,
            textColor: Colors.indigo,
            hintColor: Colors.indigo.withOpacity(0.7),
            borderRadius: 20,
            showPrefixIcon: true,
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Регистрация",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAPICallProcess = true;
                  });
                  RegisterRequestModel model = RegisterRequestModel(firstName: firstname, lastName: lastname, email: username, password: password, city: city, district: district);
                  APIService.register(model).then((responce){
                    if (responce.jwtToken != null) {
                      FormHelper.showSimpleAlertDialog(context, Config.appName, "Вы зарегистрированы! Пожалуйста, войдите в аккаунт", "OK", () {
                        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                      });
                      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                    } else {
                      FormHelper.showSimpleAlertDialog(context, Config.appName, responce.description!, "OK", () {
                        Navigator.pop(context);
                      });
                    }
                  });
                }
              },
              btnColor: Colors.greenAccent,
              borderColor: Colors.indigo,
              txtColor: Colors.indigo,
              borderRadius: 20
            ),
          ),
        ],
      )
    );
  }
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      return true;
    }
    return false;
  }
}