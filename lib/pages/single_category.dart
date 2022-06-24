import 'package:cleaners_app/constants.dart';
import 'package:cleaners_app/model/service_model.dart';
import 'package:cleaners_app/widgets/single_service.dart';
import 'package:flutter/material.dart';

class SingleCategory extends StatefulWidget {
  String categoryName;
  var items;
  SingleCategory({Key? key, required this.categoryName, required this.items})
      : super(key: key);

  @override
  State<SingleCategory> createState() => _SingleCategoryState();
}

class _SingleCategoryState extends State<SingleCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.pink,
      //alignment: Alignment.topLeft,
      height: 180,
      margin: EdgeInsets.symmetric(vertical: 5),
      child:
          //Flexible(
          Column(
        // shrinkWrap: true,
        children: [
          SizedBox(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                widget.categoryName,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.items.length,
                itemBuilder: (ctx, index) {
                  return SingleItem(
                    serviceModel: ServiceModel.fromJson(widget.items[index]),
                  );
                }),
          ),
        ],
      ),
      //),
    );
  }
}
