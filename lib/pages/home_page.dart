import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cleaners_app/constant.dart';
import 'package:cleaners_app/model/service_model.dart';
import 'package:cleaners_app/model/user_model.dart';
import 'package:cleaners_app/pages/contact_us.dart';
import 'package:cleaners_app/pages/sign_in.dart';
import 'package:cleaners_app/pages/signout_view.dart';
import 'package:cleaners_app/pages/single_category.dart';
import 'package:cleaners_app/utils/logout.dart';
import 'package:cleaners_app/widgets/banner_widget.dart';
import 'package:cleaners_app/widgets/head_slider.dart';
import 'package:cleaners_app/widgets/single_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences? _sharedPreferences;
  ServiceModel thumbnail = new ServiceModel();
  List<ServiceModel> listFeaturedServices = [];
  Future<List<dynamic>> fetch_services(category) async {
    // var request = await http.post(Uri.parse(root_domain + "fetch_services.php"),
    //     body: {
    //       "fetch_services": "fetch_services",
    //       "user_id": "offline",
    //       "category": category
    //     });
    _sharedPreferences = await SharedPreferences.getInstance();

    if (_sharedPreferences!.getString("data") != null) {
      var data = _sharedPreferences!.getString("data");
      // print(data);
      var response = jsonDecode(data!);
      // print(response);
      ///if (response.length != 0) {
      print("111111");
      return response[category];

      // }

      // return [];
    } else {
      print("0000000000");
      return [];
    }
  }

  fetchThumbnail() async {
    //thumbnail = new ServiceModel();
    var list = await fetch_services("thumbnail");
    // print(list);
    if (list.length > 0) {
      thumbnail = ServiceModel.fromJson(list[0]);
    }
    setState(() {});
  }

  fetchFetured() async {
    //thumbnail = new ServiceModel();
    var list = await fetch_services("featured");
    // print(list);

    for (int i = 0; i < list.length; i++) {
      listFeaturedServices.add(ServiceModel.fromJson(list[i]));
    }
    setState(() {});
  }

  @override
  void initState() {
    fetchFetured();
    fetchThumbnail();
    //fetch_services();
    // TODO: implement initState
    super.initState();
  }

  refreshContent() async {
    var resquest = await http.post(
        Uri.parse(
          root_domain + "fetch_content.php",
        ),
        body: {"fetch_content": "fetch_content"});
    //print(resquest.statusCode);
    if (resquest.statusCode == 200) {
      var response = jsonDecode(resquest.body);
      if (response['status']) {
        _sharedPreferences = await SharedPreferences.getInstance();
        _sharedPreferences!.setString("data", jsonEncode(response['data']));
        // var route = MaterialPageRoute(builder: (BuildContext) => MainPage());
        Navigator.pushNamed(context, "/MainPage");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Timer(Duration(seconds: 3), () {});
        await refreshContent();
      },
      child: Scaffold(
        drawer: drawer(),
        appBar: AppBar(
          foregroundColor: Colors.black,
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            appName,
            style: TextStyle(color: Colors.black, fontFamily: "Raleway"),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            // height: 300,
            child: Column(
              children: [
                HeadSlider(
                  servicesModels: listFeaturedServices,
                ),
                thumbnail.category_id != null
                    ? HomeBanner(
                        serviceModel: thumbnail,
                      )
                    : Container(),
                Container(
                  // height: ,
                  child: FutureBuilder(
                    future: fetch_services("others"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData) {
                        Size size = MediaQuery.of(context).size;
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return listOfItems(snapshot.data);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget drawer() {
    Widget title(var text) {
      return Text(
        text,
        style: ralewaytextStyle(),
      );
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: primaryColor,
                child: Image.asset(
                  "assets/images/flyer1.jpg",
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              )),
          ListTile(
            leading: Icon(Icons.home, color: primaryColor),
            title: title("Home"),
            onTap: () {
              Navigator.pushNamed(context, "/MainPage");
            },
          ),
          ListTile(
            leading: Icon(Icons.list, color: primaryColor),
            title: title("Categories"),
            onTap: () {
              Navigator.pushNamed(context, "/Categories");
            },
          ),
          ListTile(
            leading: Icon(Icons.email, color: primaryColor),
            title: title("Contact us"),
            onTap: () {
              var route =
                  MaterialPageRoute(builder: (BuildContext) => ContactUs());
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: Icon(Icons.share, color: primaryColor),
            title: title("Share App"),
            onTap: () {
              Share.share("Hello friend Install " +
                  appName +
                  " and enjoy easy, professional and fast cleaning services \n App Link : " +
                  appLink);
            },
          ),
          ListTile(
            leading: Icon(Icons.star, color: primaryColor),
            title: title("Rate Us"),
            onTap: () {
              LaunchReview.launch(
                  androidAppId: androidAppId, iOSAppId: iOSAppId);
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: userModel.id != null ? true : false,
            child: ListTile(
              leading: Icon(Icons.logout, color: primaryColor),
              title: title("Logout"),
              onTap: () async {
                logOut(userModel, context);

                // Navi
              },
            ),
          ),
          Visibility(
            visible: userModel.id != null ? false : true,
            child: ListTile(
              leading: Icon(Icons.person, color: primaryColor),
              title: Text("Login"),
              onTap: () async {
                var route =
                    MaterialPageRoute(builder: (BuildContext) => SignIn());
                Navigator.push(context, route);

                // Navi
              },
            ),
          ),
          companyModel.stable_version != null
              ? int.parse(companyModel.stable_version!) > appVersion
                  ? ListTile(
                      leading: Icon(Icons.update, color: primaryColor),
                      title: Text("Update App"),
                      onTap: () {
                        LaunchReview.launch(
                            androidAppId: androidAppId, iOSAppId: iOSAppId);
                      },
                    )
                  : Container()
              : Container()
        ],
      ),
    );
  }

  Widget listOfItems(items) {
    return AlignedGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) {
        return SingleItem(serviceModel: ServiceModel.fromJson(items[index]));
      },
      itemCount: items.length,
    );
  }

  // Widget categories() {
  //   fetch_services.forEach(key, value){

  //   };
  //}
}
