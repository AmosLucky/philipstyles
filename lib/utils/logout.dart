import 'package:cleaners_app/pages/main_page.dart';
import 'package:cleaners_app/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

Future<void> logOut(UserModel userModel, BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove("username");
  sharedPreferences.remove("password");

  userModel = new UserModel();
  var route = MaterialPageRoute(builder: (BuildContext) => SignIn());
  Navigator.push(context, route);
}
