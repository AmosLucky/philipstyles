import 'dart:convert';

import 'package:cleaners_app/constants.dart';
import 'package:cleaners_app/model/order_model.dart';
import 'package:cleaners_app/widgets/ahimma_preloader.dart';
import 'package:cleaners_app/widgets/single_order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  fetch_orders() async {
    var request = await http.post(Uri.parse(root_domain + "fetch_orders.php"),
        body: {"fetch_orders": "fetch_orders", "user_id": userModel.id!});
    var response = jsonDecode(request.body);
    print(response);
    if (response['status'] == true) {
      return response['data'];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        leading: Container(),
        title: Text(
          "My Orders",
          style: TextStyle(fontFamily: "Raleway"),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: fetch_orders(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error Occored"),
              );
            } else if (!snapshot.hasData) {
              return Shima();
            }
            return ListSingleOrder(snapshot.data);
          },
        ),
      ),
    );
  }

  ListSingleOrder(dynamic? listOrders) {
    if (listOrders!.length == 0) {
      return Center(
        child: Text("No record found"),
      );
    }
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return SingleOrder(orderModel: OrderModel.fromJSON(listOrders[index]));
      },
      itemCount: listOrders!.length,
    );
  }
}
