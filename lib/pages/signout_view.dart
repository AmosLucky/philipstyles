import 'package:cleaners_app/constant.dart';
import 'package:cleaners_app/pages/sign_in.dart';
import 'package:cleaners_app/pages/sign_up.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SignOutView extends StatefulWidget {
  String tiltle, subtitle, text, image;
  String? landing_page;
  SignOutView(
      {Key? key,
      required this.tiltle,
      required this.subtitle,
      required this.text,
      required this.image,
      this.landing_page})
      : super(key: key);

  @override
  State<SignOutView> createState() => _SignOutViewState();
}

class _SignOutViewState extends State<SignOutView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: size.height / 13, horizontal: size.width / 14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  widget.tiltle,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Raleway",
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: size.height / 7,
              ),
              Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/" + widget.image,
                      height: 200,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.text,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                            shape: StadiumBorder(),
                            onPressed: () {
                              var route = MaterialPageRoute(
                                  builder: (BuildContext) => SignUp(
                                        landing: widget.landing_page,
                                      ));
                              Navigator.of(context).push(route);
                            },
                            textColor: Colors.white,
                            color: primaryColor,
                            child: Text("Sign up")),
                        MaterialButton(
                            shape: StadiumBorder(),
                            onPressed: () {
                              var route = MaterialPageRoute(
                                  builder: (BuildContext) =>
                                      SignIn(landing: widget.landing_page));
                              Navigator.of(context).push(route);
                            },
                            textColor: Colors.white,
                            color: primaryColor,
                            child: Text("Sign in"))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
