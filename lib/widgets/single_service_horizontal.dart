import 'package:cleaners_app/constants.dart';
import 'package:cleaners_app/model/service_model.dart';
import 'package:cleaners_app/pages/service_details.dart';
import 'package:cleaners_app/widgets/image_loader.dart';
import 'package:flutter/material.dart';

class SingleItemHorizontal extends StatelessWidget {
  ServiceModel serviceModel;
  SingleItemHorizontal({Key? key, required this.serviceModel})
      : super(key: key);
  String minimizeLength(String content, type) {
    switch (type) {
      case "title":
        if (content.length > 40) {
          return content.substring(0, 40) + "...";
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
            elevation: 3.0,
            child: Container(
                // width: MediaQuery.of(context).size.width / 2,
                child: ListTile(
              // leading: Container(
              //   child: loadImage(
              //     url: serviceModel.service_picture!,
              //     height: 200,
              //     width: MediaQuery.of(context).size.width / 5,
              //   ),
              // ),
              title: Text(
                minimizeLength(serviceModel.service_title!, "title"),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              // trailing: Text(
              //   "Contact us",
              //   style: TextStyle(color: Colors.blue),
              // ),
              subtitle: Text(
                "",
                style: TextStyle(fontFamily: "", fontWeight: FontWeight.bold),
              ),
            ))),
      ),
    );
  }
}
