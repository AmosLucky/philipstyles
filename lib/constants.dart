import 'package:cleaners_app/model/company_model.dart';
import 'package:cleaners_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var appName = "Philipstyles";
var slogan = "... best cleaning service";

var whitColor = Colors.white;
var primaryColor = Colors.blue[600];
var secondaryColor = Colors.greenAccent;
var root_domain = "https://unlimitedsub.com/philipstyles/api/";
//var root_domain = "http://192.168.43.95/web-projects/cleaners_app/api/";
var image_route = "https://philip.unlimitedsub.com/storage/images/";
//var image_route = "";
UserModel userModel = new UserModel();
CompanyModel companyModel = new CompanyModel();
var appVersion = 1;
var appLink =
    "https://play.google.com/store/apps/details?id=philipstyles_cleaning_service.com";
var androidAppId = "";
var iOSAppId = "";
var nairaSign = "₦";

String addCommer(String price) {
  var f = NumberFormat("###,###.0#", "en_US");
  return f.format(int.parse(price)).toString();
}

TextStyle ralewaytextStyle() {
  return TextStyle(fontFamily: "Raleway");
}
