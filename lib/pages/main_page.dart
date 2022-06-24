import 'dart:async';
import 'dart:convert';

import 'package:cleaners_app/constants.dart';
import 'package:cleaners_app/model/company_model.dart';
import 'package:cleaners_app/pages/home_page.dart';
import 'package:cleaners_app/pages/orders.dart';
import 'package:cleaners_app/pages/signout_view.dart';
import 'package:cleaners_app/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:launch_review/launch_review.dart';

class MainPage extends StatefulWidget {
  int? currentIndex = 0;
  MainPage({Key? key, this.currentIndex}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //class _DashboardState extends State<Dashboard> {
  var currentIndex = 0;
  var numTasks = 0;

  PageController _controller = PageController(
    initialPage: 0,
  );

  int exit = 0;

  @override
  void initState() {
    fetch_company();
    if (widget.currentIndex != null) {
      //currentIndex = widget.currentIndex!;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool returnBackPress() {
    // loadInterstitialAd();
    //startAdsCounter();
    if (exit < 1) {
      exit++;

      Fluttertoast.showToast(msg: "Double tap  to exit");
      Timer(Duration(seconds: 2), () {
        exit = 0;
        setState(() {});
      });

      setState(() {});
      return false;
    } else {
      SystemNavigator.pop();
      exit = 0;
      return false;
    }
  }

  fetch_company() async {
    var request =
        await http.post(Uri.parse(root_domain + "fetch_company.php"), body: {
      "fetch_company": "fetch_company",
      "user_id": "offline",
    });

    if (request.statusCode == 200) {
      var response = jsonDecode(request.body);
      print(response);
      if (response['status'] == true) {
        //print("lllllllllll");
        companyModel = CompanyModel.fromJSON(response['data'][0]);
        if (double.parse(companyModel.stable_version!) > appVersion) {
          showUpdateAlert(context);
        }
      }

      return [];
    } else {
      return [];
    }
  }

  showUpdateAlert(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: AlertDialog(
            title: Text(
              "New Version",
              style: TextStyle(color: primaryColor),
            ),
            content: Text(
                "We have launched a new version of this app \n Please update your app to enjoy a better service from us"),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  LaunchReview.launch(
                      androidAppId: androidAppId, iOSAppId: iOSAppId);
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return returnBackPress();
      },
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (_index) {
              currentIndex = _index;
              //print(_index);
              _controller.jumpTo(_index.toDouble());
              _controller.animateToPage(_index,
                  duration: Duration(seconds: 1), curve: Curves.easeOut);
              setState(() {});
              // switch (_index) {
              //   case 0:
              //     return;
              //   case 1:
              //     return;
              //   case 2:
              //     return;
              // }
            },
            selectedItemColor: primaryColor,
            showUnselectedLabels: true,
            //backgroundColor: Colors.black,
            unselectedItemColor: Colors.grey,
            items: [
              navItem(Icons.home, "Home"),
              navItem(Icons.list_alt, "My orders"),
              navItem(Icons.person_rounded, "Me"),
            ],
          ),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            allowImplicitScrolling: false,
            pageSnapping: false,
            controller: _controller,
            onPageChanged: (i) {
              currentIndex = i;
              setState(() {});
            },
            children: [
              HomePage(),
              userModel.id == null
                  ? SignOutView(
                      tiltle: "Orders",
                      subtitle: "No order",
                      image: "list_ill.png",
                      text:
                          "Plaese log in or sign up to make or view your orders",
                      landing_page: "orders",
                    )
                  : Orders(),
              userModel.id == null
                  ? SignOutView(
                      tiltle: "Profile",
                      subtitle: "No profile",
                      image: "no_profile_ill.png",
                      text: "Plaese log in or sign up to view your profile",
                      landing_page: "profile",
                    )
                  : UserProfile(),
            ],
          )),
    );
  }

  navItem(icon, text) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      label: text,
      // style: TextStyle(fontFamily: "Roboto"),
      //  ),
    );
  }
}
