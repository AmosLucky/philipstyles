import 'package:cleaners_app/model/order_model.dart';
import 'package:cleaners_app/widgets/image_loader.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SingleOrder extends StatefulWidget {
  OrderModel orderModel;
  SingleOrder({Key? key, required this.orderModel}) : super(key: key);

  @override
  State<SingleOrder> createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  returnTitle() {
    if (widget.orderModel.service_title!.length > 20) {
      return widget.orderModel.service_title!.substring(0, 20) + "....";
    } else {
      return widget.orderModel.service_title!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      height: 100,
      padding: EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Card(
        margin: EdgeInsets.all(4),
        elevation: 3.0,
        child: ListTile(
          leading: loadImage(
            url: widget.orderModel.service_picture!,
            width: 100,
            height: 100,
          ),
          title: Text(
            returnTitle(),
          ),
          subtitle: Text(nairaSign + widget.orderModel.service_price!),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.orderModel.order_date!),
              Text(widget.orderModel.order_status!),
            ],
          ),
        ),
      ),
    );
  }
}
