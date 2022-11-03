import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/service_model.dart';
import '../widgets/single_service.dart';
import '../widgets/single_service_horizontal.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  SharedPreferences? _sharedPreferences;
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
      print(response);

      ///if (response.length != 0) {
      print("111111");
      return response[category];

      // }

      // return [];
    } else {
      //print("0000000000");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        // height: ,
        child: FutureBuilder(
          future: fetch_services("exclusive"),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData) {
              Size size = MediaQuery.of(context).size;
              return Center(child: CupertinoActivityIndicator());
            }

            return listOfItems(snapshot.data);
          },
        ),
      ),
    );
  }

  Widget listOfItems(items) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
              verticalOffset: 50.0,
              child: ScaleAnimation(
                  child: SingleItemHorizontal(
                      serviceModel: ServiceModel.fromJson(items[index])))),
        );
      }),
      itemCount: items.length,
    );
  }
}
