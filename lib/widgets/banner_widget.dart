import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaners_app/constant.dart';
import 'package:cleaners_app/model/service_model.dart';
import 'package:cleaners_app/pages/service_details.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HomeBanner extends StatefulWidget {
  ServiceModel? serviceModel;
  HomeBanner({Key? key, required this.serviceModel}) : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  String minimizeLength(String content, type) {
    switch (type) {
      case "title":
        if (content.length > 20) {
          return content.substring(0, 20) + "...";
        }
        return content;

      case "category":
        if (content.length > 18) {
          return content.substring(0, 18) + "...";
        }
        return content;

      case "content":
        if (content.length > 30) {
          return content.substring(0, 30) + "...";
        }
        return content;

      default:
        return content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var route = MaterialPageRoute(
            builder: (BuildContext) =>
                ServiceDetails(serviceModel: widget.serviceModel!));
        Navigator.push(context, route);
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: CachedNetworkImageProvider(
                    widget.serviceModel!.service_picture!,
                  ))),
          margin: const EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width,
          child: ClipRect(
            /** Banner Widget **/
            child: Banner(
              message: "promo % off !!",
              location: BannerLocation.bottomStart,
              color: Colors.red,
              child: Container(
                //color: Colors.green[100],
                height: 300,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Image.network(
                      //     "http://bookdirtbusters.com/wp-content/uploads/2020/12/Professional-Cleaners.jpg"),
                      //Image.network
                      SizedBox(height: 30),
                      Text(
                        minimizeLength(
                            widget.serviceModel!.service_title!, "title"),
                        style: TextStyle(
                          color: whitColor,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black12,
                        ), //TextStyle
                      ),
                      SizedBox(
                        height: 5,
                      ), //SizedBox

                      Text(
                        minimizeLength(
                            widget.serviceModel!.service_content!, "content"),
                        style: TextStyle(
                            backgroundColor: Colors.black12,
                            color: whitColor,
                            fontSize: 18,
                            fontWeight: FontWeight.normal), //TextStyle
                      ), //Text
                      SizedBox(height: 20),

                      Text(
                        "Starting from " +
                            nairaSign +
                            addCommer(widget.serviceModel!.lower_price!) +
                            " only!",
                        style: TextStyle(
                            color: whitColor,
                            fontSize: 22,
                            backgroundColor: Colors.black12,
                            fontFamily: "",
                            fontWeight: FontWeight.w500), //TextStyle
                      ), //Text
                      SizedBox(height: 20),
                      MaterialButton(
                        shape: StadiumBorder(),
                        onPressed: () {
                          var route = MaterialPageRoute(
                              builder: (BuildContext) => ServiceDetails(
                                  serviceModel: widget.serviceModel!));
                          Navigator.push(context, route);
                        },
                        child: Text("Book Now"),
                        textColor: whitColor,
                        color: primaryColor,
                      ) //RaisedButton
                    ], //<Widget>[]
                  ), //Column
                ), //Padding
              ), //Container
            ), //Banner
          ), //ClipRect
        ), //container
      ),
    ); //Center
  }
}
