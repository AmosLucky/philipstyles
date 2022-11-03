import 'dart:convert';

import 'package:cleaners_app/model/user_model.dart';
import 'package:cleaners_app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  String? landing;
  SignUp({Key? key, this.landing}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var username = "";
  var password = "";
  var erro_msg = "";
  var address = "";
  var email = "";
  var phone_number = "";
  bool isShow = false;
  bool isLoading = false;
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
    Route route = MaterialPageRoute(builder: (BuildContext) => MainPage());
    Navigator.push(context, route);
    //if (widget.landing == "profile") {

    //   Navigator.pushNamed(context, "/MainPage");
    // } else if (widget.landing == "orders") {
    //   Navigator.pushNamed(context, "/MainPage");
    // } else {
    //   Navigator.pushNamed(context, "/MainPage");
    // }
  }

  SharedPreferences? sharedPreferences;

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
                height: size.height / 15,
              ),
              Container(
                width: size.width,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/reg_ill.png",
                  height: size.height / 6,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width / 13),
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
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[300],
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.blueAccent,
                              ),
                              // labelStyle:
                              //     TextStyle(fontSize: 16, color: Colors.black38),
                              hintStyle: TextStyle(
                                  fontSize: 16, color: Colors.black38),
                              labelText: "Email",
                              hintText: "Email",
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
                            email = val;
                          },
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Email can't be empty";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[300],
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.blueAccent,
                              ),
                              // labelStyle:
                              //     TextStyle(fontSize: 16, color: Colors.black38),
                              hintStyle: TextStyle(
                                  fontSize: 16, color: Colors.black38),
                              labelText: "Phone number",
                              hintText: "Phone number",
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
                            phone_number = val;
                          },
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Phone number can't be empty";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        //height: 55,
                        child: TextFormField(
                          minLines: 2,
                          maxLines: 10,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[300],
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Colors.blueAccent,
                              ),
                              // labelStyle:
                              //     TextStyle(fontSize: 16, color: Colors.black38),
                              hintStyle: TextStyle(
                                  fontSize: 16, color: Colors.black38),
                              labelText: "Address",
                              hintText: "Address",
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
                            address = val;
                          },
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Address can't be empty";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                erro_msg,
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            )
                          : Container(),
                      Visibility(
                          visible: isLoading,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: LinearProgressIndicator(),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: size.height / 15,
                        width: size.width,
                        child: MaterialButton(
                          shape: StadiumBorder(),
                          onPressed: () {
                            // userModel.id = "1";
                            // userModel.username = "user";
                            // userModel.address = "address";
                            // userModel.phoneNumber = "08106799953";
                            // userModel.password = "08106799953";
                            // navigator();

                            erro_msg = "";
                            setState(() {});
                            if (validate()) {
                              _formKey.currentState!.save();
                              setState(() {
                                isLoading = true;
                              });
                              signUp(
                                  username: username,
                                  password: password,
                                  email: email,
                                  phone_number: phone_number,
                                  address: address);
                            }
                          },
                          textColor: Colors.white,
                          color: primaryColor,
                          child: Text("Sign Up"),
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
                                  Navigator.pushNamed(context, "/SingnIn");
                                },
                                child: Text(
                                  "Sign in",
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
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (username.trim().length < 2) {
      erro_msg = "Username is too short";

      setState(() {});
      return false;
    } else if (!emailValid) {
      erro_msg = "Invalid email";

      setState(() {});
      return false;
    } else if (phone_number.trim().length < 10) {
      erro_msg = "Invalid phone number";

      setState(() {});
      return false;
    } else if (address.trim().length < 5) {
      erro_msg = "Address is too short";

      setState(() {});
      return false;
    } else if (password.trim().length < 5) {
      erro_msg = "Password must be greater than 5 characters";

      setState(() {});
      return false;
    }
    erro_msg = "";
    setState(() {});
    return true;
  }

  signUp({username, password, email, phone_number, address}) async {
    var request =
        await http.post(Uri.parse(root_domain + "register.php"), body: {
      "register": "register",
      "username": username,
      "password": password,
      "email": email,
      "phone_number": phone_number,
      "address": address
    });

    if (request.statusCode == 200) {
      var response = jsonDecode(request.body);
      if (response['status'] == true) {
        userModel = UserModel.fromJson(response["data"]);
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences!.setString("username", username);
        sharedPreferences!.setString("password", password);
        isLoading = false;
        navigator();
      } else {
        erro_msg = response['msg'];
        setState(() {});
      }
    } else {
      erro_msg = "Internet error: please check your internet connection";
      setState(() {});
    }
    isLoading = false;
    setState(() {});
  }
}
