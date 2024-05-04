import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/config.dart';
import 'package:flutter_application_2/models/login_models.dart';
import 'package:flutter_application_2/services/api_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: HexColor("#283B71"),
        backgroundColor: Colors.greenAccent,
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _loginUI(context)
          ),
        key: UniqueKey(),
        inAsyncCall: isAPICallProcess,
        opacity: 0.3,
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
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
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.contain
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 30,
              top: 50
            ),
            child: Center(
              child: Text(
                "Вход",
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
              password = onSavedVal;
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
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Войти",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAPICallProcess = true;
                  });
                  LoginRequestModel model = LoginRequestModel(email: username, password: password);
                  APIService.login(model).then((responce){
                    setState(() {
                      isAPICallProcess = false;
                    });
                    if (responce) {
                      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                    } else {
                      FormHelper.showSimpleAlertDialog(context, Config.appName, "неправильные почта или пароль", "OK", () {
                        Navigator.pop(context);
                      });
                    }
                  });
                }
              },
              btnColor: Colors.greenAccent,
              borderColor: Colors.indigo,
              txtColor: Colors.indigo,
              borderRadius: 25
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(child: Text("или", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo),)),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Color.fromARGB(255, 99, 112, 189),
                    fontSize: 14.0
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Нет аккаунта? "),
                    TextSpan(
                      text: "Зарегистрироваться",
                      style: TextStyle(color: Colors.indigo, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, "/register");
                        },
                    )
                  ]
                )
              ),
            ),
          )
        ],
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