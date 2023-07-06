import 'dart:io';

import 'package:cleaners_app/constants.dart';
import 'package:cleaners_app/model/service_model.dart';
import 'package:cleaners_app/widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/utils.dart';
import 'payment_page.dart';

class ServiceDetails extends StatefulWidget {
  ServiceModel serviceModel;
  ServiceDetails({Key? key, required this.serviceModel}) : super(key: key);

  @override
  State<ServiceDetails> createState() =>
      _ServiceDetailsState(serviceModel: serviceModel);
}

class _ServiceDetailsState extends State<ServiceDetails> {
  ServiceModel serviceModel;
  _ServiceDetailsState({required this.serviceModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //floatingActionButtonLocation: FloatingActionButtonLocation,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        child: Image.asset(
          "assets/images/whatsapp.png",
          width: 30,
        ),
        onPressed: () {
          whatsapp();
          // launch("https://wa.me/+234" +
          //     companyModel.whatsapp_number! +
          //     "/?text= i want to book for your service \n Title: " +
          //     serviceModel.service_title! +
          //     "\n Price :N" +
          //     serviceModel.service_price! +
          //     " \n Category :" +
          //     serviceModel.category!);
        },
      ),
      appBar: AppBar(
        title: Text(serviceModel.service_title!),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: loadImage(
                url: serviceModel.service_picture!,
                width: size.width,
                height: 250,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 230),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        serviceModel.service_title!,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: false,
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.layers),
                            SizedBox(
                              width: 20,
                            ),
                            Text(serviceModel.category!),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: int.parse(serviceModel.service_price!) != 0
                          ? true
                          : false,
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.payment),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              nairaSign + addCommer(serviceModel.lower_price!),
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(" - "),
                            Text(
                              nairaSign +
                                  addCommer(serviceModel.service_price!),
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(serviceModel.service_content!),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: serviceModel.service_price == null ||
                              int.parse(serviceModel.service_price!) == 0
                          ? false
                          : true,
                      child: Container(
                        height: 50,
                        width: size.width / 1.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                width: size.width / 5,
                                child: MaterialButton(
                                  shape: StadiumBorder(),
                                  onPressed: () {
                                    showAlertDialog(context);
                                    //launch("tel:" + companyModel.phone_number!);
                                  },
                                  child: Text(
                                    "Transfer",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  textColor: primaryColor,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: MaterialButton(
                                shape: StadiumBorder(),
                                onPressed: () {
                                  var route = MaterialPageRoute(
                                      builder: (BuildContext) => PaymentPage(
                                            serviceModel: widget.serviceModel,
                                          ));
                                  Navigator.push(context, route);
                                },
                                child: Text(
                                  "Pay With Card",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                textColor: whitColor,
                                color: secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible:
                          serviceModel.service_price != null ? true : false,
                      child: Container(
                        height: 50,
                        width: size.width / 1.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width / 5,
                              child: MaterialButton(
                                onPressed: () {
                                  launch("tel:" + companyModel.phone_number!);
                                },
                                child: Icon(Icons.phone),
                                textColor: primaryColor,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: MaterialButton(
                                onPressed: () async {
                                  // _launchUrl(
                                  //     "mailto:" + companyModel.company_email!)
                                  // ;

                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: companyModel.company_email!,
                                    queryParameters: {
                                      'subject': '',
                                      'body': ''
                                    },
                                  );
                                  launchUrl(emailLaunchUri);
                                },
                                child: Text("Mail us"),
                                textColor: whitColor,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                          serviceModel.service_price == null ? true : false,
                      child: Container(
                        height: 50,
                        width: size.width / 1.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width / 5,
                              child: MaterialButton(
                                onPressed: () {
                                  _makePhoneCall(companyModel.phone_number!);
                                },
                                child: Icon(Icons.phone),
                                textColor: primaryColor,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: MaterialButton(
                                onPressed: () async {
                                  whatsapp();
                                },
                                child: Text("Chat On Whatsapp"),
                                textColor: whitColor,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  whatsapp() async {
    var contact = companyModel.whatsapp_number!;
// <<<<<<< HEAD
//     var androidUrl = "whatsapp://send?phone=$contact&text="+widget.serviceModel.service_title!;
// =======
    var androidUrl = "whatsapp://send?phone=$contact&text=I want to equire on: "+widget.serviceModel.service_title;

    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('I want to equire on: '+widget.serviceModel.service_title)}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      //EasyLoading.showError('WhatsApp is not installed.');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK", style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget continueButton = TextButton(
      child: Text(
        "Call us",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        _launchUrl(
            "https://wa.me/" + companyModel.whatsapp_number! + "/?text=");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Transfer To:",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          accountDetailsRow("Bank :", companyModel.bank!),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
              onHorizontalDragStart: (v) async {
                await Clipboard.setData(
                    ClipboardData(text: companyModel.company_account_number!));
                showSnackBar(
                    context, "Copied! " + companyModel.company_account_number!);
              },
              child: accountDetailsRow(
                  "Acc No :", companyModel.company_account_number!)),
          SizedBox(
            height: 10,
          ),
          accountDetailsRow("Acc Name :", companyModel.company_account_name!),
          // Text("Acc Name :" + companyModel.company_account_name!),

          // Text("Acc No :" + companyModel.company_account_number!)
        ],
      ),
      actions: [
        //continueButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _launchUrl(url) async {
    var _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Widget accountDetailsRow(String key, String value) {
    return Row(
      children: [
        Container(width: 100, child: Text(key)),
        SizedBox(
          width: 10,
        ),
        Expanded(child: Text(value))
      ],
    );
  }
}
