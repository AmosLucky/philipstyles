import 'package:carousel_slider/carousel_slider.dart';
import 'package:cleaners_app/model/service_model.dart';
import 'package:cleaners_app/pages/service_details.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HeadSlider extends StatefulWidget {
  List<ServiceModel> servicesModels;
  HeadSlider({required this.servicesModels, Key? key}) : super(key: key);

  @override
  State<HeadSlider> createState() => _HeadSliderState();
}

class _HeadSliderState extends State<HeadSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<ServiceModel>? servicesModels;
  @override
  void initState() {
    servicesModels = widget.servicesModels;
    // TODO: implement initState
    super.initState();
  }

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
        if (content.length > 50) {
          return content.substring(0, 50) + "...";
        }
        return content;

      default:
        return content;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      CarouselSlider(
        options: CarouselOptions(
            height: size.height / 4,
            viewportFraction: 1.0,
            enlargeCenterPage: true,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
        items: servicesModels!
            .map((item) => InkWell(
                  onTap: () {
                    var route = MaterialPageRoute(
                        builder: (BuildContext) =>
                            ServiceDetails(serviceModel: item));
                    Navigator.push(context, route);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: size.height / 4,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        // borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              item.service_picture!,
                            ))),
                    child: Banner(
                      message: "promo % off !!",
                      location: BannerLocation.topEnd,
                      color: Colors.red,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                minimizeLength(item.service_title!, "title"),
                                style: TextStyle(
                                    fontFamily: "Lato",
                                    backgroundColor: Colors.black12,
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                minimizeLength(
                                    item.service_content!, "content"),
                                style: TextStyle(
                                    backgroundColor: Colors.black12,
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                minimizeLength(
                                    "For just " +
                                        nairaSign +
                                        addCommer(item.service_price!) +
                                        " only!",
                                    ""),
                                style: TextStyle(
                                    backgroundColor: Colors.black12,
                                    fontFamily: "",
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: MaterialButton(
                                shape: StadiumBorder(),
                                onPressed: () {
                                  var route = MaterialPageRoute(
                                      builder: (BuildContext) =>
                                          ServiceDetails(serviceModel: item));
                                  Navigator.push(context, route);
                                },
                                child: Text("Book Now"),
                                textColor: whitColor,
                                color: primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: servicesModels!.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.red
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.2)),
              ),
            );
          }).toList()),
    ]);
  }
}
