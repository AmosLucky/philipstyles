import 'package:cleaners_app/constants.dart';
import 'package:cleaners_app/model/service_model.dart';
import 'package:cleaners_app/pages/service_details.dart';
import 'package:cleaners_app/widgets/image_loader.dart';
import 'package:flutter/material.dart';

class SingleItem extends StatelessWidget {
  ServiceModel serviceModel;
  SingleItem({Key? key, required this.serviceModel}) : super(key: key);
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

      default:
        return content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(serviceModel.service_picture);
        var route = MaterialPageRoute(
            builder: (BuildContext) =>
                ServiceDetails(serviceModel: serviceModel));
        Navigator.push(context, route);
      },
      child: Container(
        child: Card(
            elevation: 5.0,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 220,
              child: Column(
                children: [
                  loadImage(
                    url: serviceModel.service_picture!,
                    height: 100,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            minimizeLength(
                                serviceModel.service_title!, "title"),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Container(
                              child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(Icons.layers,
                                    size: 15, color: Colors.grey),
                              ),
                              Container(
                                child: Text(
                                  minimizeLength(
                                      serviceModel.category!, "category"),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          )),
                          serviceModel.service_price!.length > 2
                              ? Row(children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(Icons.payment,
                                        size: 15, color: Colors.grey),
                                  ),
                                  Container(
                                    ///margin: EdgeInsets.only(left: 19),
                                    child: Text(
                                      nairaSign +
                                          addCommer(serviceModel.lower_price!),
                                      style: TextStyle(
                                          fontFamily: "",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ])
                              : Container(),
                          // Divider(
                          //   color: Colors.grey,
                          // )
                        ],
                      )),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Book Now",
                          style: TextStyle(color: primaryColor),
                        ),
                        Icon(Icons.launch, size: 15, color: primaryColor)
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
