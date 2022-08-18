import 'dart:convert';

import 'package:cleaners_app/constant.dart';
import 'package:cleaners_app/model/user_model.dart';
import 'package:cleaners_app/pages/main_page.dart';
import 'package:cleaners_app/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SignIn extends StatefulWidget {
  String? landing;
  SignIn({Key? key, this.landing}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SharedPreferences? sharedPreferences;
  var username = "";
  var password = "";
  var erro_msg = "";
  bool isShow = false;
  void showPassword() {
    if (isShow) {
      isShow = false;
      setState(() {});
    } else {
      isShow = true;
      setState(() {});
    }
  }

  var _formKey = GlobalKey<FormState>();

  void navigator() {
    Navigator.pushNamed(context, "/MainPage");
    Route? route;
    // return;
    // if (widget.landing == "profile") {
    //   route = MaterialPageRoute(
    //       builder: (BuildContext) => MainPage(
    //             currentIndex: 2,
    //           ));
    //   Navigator.push(context, route);
    // } else if (widget.landing == "orders") {
    //   route = MaterialPageRoute(
    //       builder: (BuildContext) => MainPage(
    //             currentIndex: 1,
    //           ));
    //   Navigator.push(context, route);
    // } else {
    //   Navigator.pushNamed(context, "/MainPage");
    // }
  }

  var user_error = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                height: size.height / 7,
              ),
              Container(
                width: size.width,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/login_ill2.png",
                  height: size.height / 4,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width / 12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[300],
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.blueAccent,
                              ),
                              // labelStyle:
                              //     TextStyle(fontSize: 16, color: Colors.black38),
                              hintStyle: TextStyle(
                                  fontSize: 16, color: Colors.black38),
                              labelText: "Username",
                              hintText: "Username",
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(width: 0.5),
                              // ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.1),
                              ),
                              disabledBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          onChanged: (val) {
                            username = val;
                          },
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Username can't be empty";
                            }
                          },
                        ),
                      ),
                      Visibility(
                          visible: user_error == "" ? true : false,
                          child: Container(
                            child: Text(user_error),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                          obscureText: isShow ? false : true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[300],
                              prefixIcon: IconButton(
                                onPressed: () {
                                  showPassword();
                                },
                                icon: Icon(
                                  isShow
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              // labelStyle:
                              //     TextStyle(fontSize: 16, color: Colors.black38),
                              hintStyle: TextStyle(
                                  fontSize: 16, color: Colors.black38),
                              labelText: "Password",
                              hintText: "Password",
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(width: 0.5),
                              // ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.1),
                              ),
                              disabledBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          onChanged: (val) {
                            password = val;
                          },
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "password can't be empty";
                            }
                          },
                        ),
                      ),
                      erro_msg != ""
                          ? Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                erro_msg,
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: size.height / 15,
                        width: size.width,
                        child: MaterialButton(
                          shape: StadiumBorder(),
                          onPressed: () {
                            erro_msg = "";
                            setState(() {});
                            if (validate()) {
                              //_formKey.currentState!.save();
                              signIn(username, password);
                            }
                          },
                          textColor: Colors.white,
                          color: primaryColor,
                          child: Text("Sign In"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/SingnUp");
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(color: primaryColor),
                                ))
                          ])
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    if (username.trim().length < 2) {
      erro_msg = "Invalid username";

      setState(() {});
      return false;
    } else if (password.trim().length < 5) {
      erro_msg = "Invalid password";

      setState(() {});
      return false;
    }
    erro_msg = "";
    setState(() {});
    return true;
  }

  signIn(username, password) async {
    var request = await http.post(Uri.parse(root_domain + "login.php"),
        body: {"login": "", "username": username, "password": password});

    if (request.statusCode == 200) {
      var response = jsonDecode(request.body);
      if (response['status'] == true) {
        userModel = UserModel.fromJson(response["data"]);
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences!.setString("username", username);
        sharedPreferences!.setString("password", password);
        navigator();
      } else {
        erro_msg = "Incorrect sername or password";
        setState(() {});
      }
    } else {
      erro_msg = "Internet error: please check your internet connection";
      setState(() {});
    }
  }
}
