import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cleaners_app/constant.dart';
import 'package:cleaners_app/model/order_model.dart';
import 'package:cleaners_app/model/user_model.dart';
import 'package:cleaners_app/pages/categories.dart';
import 'package:cleaners_app/pages/home_page.dart';
import 'package:cleaners_app/pages/main_page.dart';
import 'package:cleaners_app/pages/sign_in.dart';
import 'package:cleaners_app/pages/sign_up.dart';
import 'package:cleaners_app/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'pages/orders.dart';

var headers = {
  "Access-Control-Allow-Origin": "*", // Required for CORS support to work
  "Access-Control-Allow-Credentials":
      "true", // Required for cookies, authorization headers with HTTPS
  "Access-Control-Allow-Headers":
      "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  "Access-Control-Allow-Methods": "POST, OPTIONS"
};

void main() {
  //HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/MainPage": (ctx) => MainPage(),
        '/Orders': (ctx) => Orders(),
        '/UserProfile': (ctx) => UserProfile(),
        '/Register': (ctx) => SignUp(),
        '/Home': (ctx) => HomePage(),
        '/SingnUp': (ctx) => SignUp(),
        '/SingnIn': (ctx) => SignIn(),
        '/Categories': (ctx) => Categories()
        //'/Redeem': (ctx) => Redeem(),
        //'/Welcome': (ctx) => WelcomePage(),
        //'/ForgetPassword': (ctx) => ForgetPassword(),
      },
      title: appName,
      theme: ThemeData(
        fontFamily: "Raleway",
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  SharedPreferences? _sharedPreferences;
  //Timer(Duration(seconds:3));
  @override
  goToWelcome() {
    //Timer(Duration(seconds: 4), () {
    //Navigator.pushNamed(context, "/MainPage");
    // });
  }

  var controler;
  var animation;
  //var opacity;
  // var fadeController;
  showAnimation() {
    Timer(Duration(seconds: 1), () {
      fetchDataInitialData();
    });
  }

  void initState() {
    controler =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween(begin: 0.0, end: 1.0).animate(controler);
    controler.forward();

    showAnimation();
    Timer(Duration(seconds: 1), () {
      fetchContent();
      print("22");
    });

    //Timer(Duration(seconds: 4), () {});
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controler.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  fetchDataInitialData() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? username = _sharedPreferences!.getString("username");
    String? password = _sharedPreferences!.getString("password");
    if (password == null || username == null) {
      goToWelcome();
    } else {
      login(username.toString(), password.toString());
    }
  }

  void login(String username, password) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    Uri uri = Uri.parse(root_domain + "login.php");
    print(uri);
    HttpClient client = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    var ioClient = new IOClient(client);
    http.Response resquest = await ioClient.post(uri,
        body: {"username": username, "password": password, "login": "login"},
        headers: headers);
    // var resquest = await http.post(uri,
    //     body: {"username": username, "password": password, "login": "login"});
    // print(resquest.statusCode);
    if (resquest.statusCode == 200) {
      var response = jsonDecode(resquest.body);
      if (response['status'] == true) {
        _sharedPreferences!.setString("username", username);
        _sharedPreferences!.setString("password", password);
        userModel = UserModel.fromJson(response['data']);
        goToWelcome();
        // print(response);
        // var userDetails = response['bio'];
        // var settingsDetails = response['settings'];
        // var stableVersion = settingsDetails['stableVersion'];

        // if (int.parse(stableVersion) > appVersion) {
        //   showAlertDialogUPdate(context, "New Update",
        //       "Your app is out of date, please update it to enjoy a better service");
        //   return;
        // }

        // Navigator.pushNamed(context, "/Welcome");
        // Navigator.pushNamed(context, "/Dashboard");
      } else {
        goToWelcome();
      }
    } else {
      goToWelcome();
    }
  }

  bool isErro = false;

  fetchContent() async {
    print("here");
    HttpClient client = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    var ioClient = new IOClient(client);
    var resquest = await ioClient.post(
        Uri.parse(
          root_domain + "fetch_content.php",
        ),
        body: {"fetch_content": "fetch_content"},
        headers: headers);
    //print(resquest.statusCode);
    if (resquest.statusCode == 200) {
      print("200");
      var response = jsonDecode(resquest.body);
      print(response);
      if (response['status']) {
        _sharedPreferences = await SharedPreferences.getInstance();
        _sharedPreferences!.setString("data", jsonEncode(response['data']));
        var route = MaterialPageRoute(builder: (BuildContext) => MainPage());
        Navigator.push(context, route);
      } else {
        if (_sharedPreferences!.getString("data") != null) {
          Timer(
              Duration(
                seconds: 2,
              ), () {
            var route =
                MaterialPageRoute(builder: (BuildContext) => MainPage());
            Navigator.push(context, route);
          });
          return;
        }
        isErro = true;
        setState(() {});
      }
    } else {
      isErro = true;
      setState(() {});
      print("erro");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                  scale: animation,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 200,
                  )),
              FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Interval(0.5, 1.0),
                  ),
                ),
                child: Text(
                  slogan,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Visibility(
                  visible: isErro,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Internet Error: Please check your network connection"),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            var route = MaterialPageRoute(
                                builder: (BuildContext) => SplashScreen());
                            Navigator.push(context, route);
                          },
                          child: Text("Retry"))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
