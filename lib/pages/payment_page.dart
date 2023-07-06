// ignore_for_file: unnecessary_new

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cleaners_app/model/service_model.dart';
import 'package:cleaners_app/widgets/image_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../constants.dart';

// To get started quickly, change this to your heroku deployment of
// https://github.com/PaystackHQ/sample-charge-card-backend
// Step 1. Visit https://github.com/PaystackHQ/sample-charge-card-backend
// Step 2. Click "Deploy to heroku"
// Step 3. Login with your heroku credentials or create a free heroku account
// Step 4. Provide your secret key and an email with which to start all test transactions
// Step 5. Replace {YOUR_BACKEND_URL} below with the url generated by heroku (format https://some-url.herokuapp.com)
String backendUrl = 'ocashup.com';
// Set this to a public key that matches the secret key you supplied while creating the heroku instance
String paystackPublicKey = companyModel.paystack_api_key!;
//const String appName1 = appName;

class PaymentPage extends StatefulWidget {
  ServiceModel serviceModel;
  // PaystackPlugin plugin;
  PaymentPage({
    required this.serviceModel,
  });
  @override
  _PaymentPage createState() => _PaymentPage();
}

class _PaymentPage extends State<PaymentPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _verticalSizeBox = const SizedBox(height: 20.0);
  final _horizontalSizeBox = const SizedBox(width: 10.0);

  var _border = new Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.red,
  );
  int _radioValue = 0;
  CheckoutMethod _method = CheckoutMethod.card;
  bool _inProgress = false;
  String? _cardNumber;
  String? _cvv;
  int? _expiryMonth;
  int? _expiryYear;
  //var plugin = PaystackPlugin();

  final plugin = PaystackPlugin();
  int? amount;
  String dropdownvalue = "";
  String paidPrice = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    plugin.initialize(publicKey: paystackPublicKey);
    setState(() {
      amount = int.parse(widget.serviceModel.service_price!) * 100;
      ;
    });

    // TODO: implement initState
    super.initState();
    init();
  }

  setPrice(value) {
    if (value == nairaSign + addCommer(widget.serviceModel.service_price!)) {
      amount = int.parse(widget.serviceModel.service_price!) * 100;
      paidPrice = widget.serviceModel.service_price!;
    } else {
      amount = int.parse(widget.serviceModel.lower_price!) * 100;
      paidPrice = widget.serviceModel.lower_price!;
    }
    print(amount);
    print(amount);
  }

  bool isInitialized = false;

  void init() {
    dropdownvalue = nairaSign + addCommer(widget.serviceModel.service_price!);
    paidPrice = widget.serviceModel.service_price!;
    Timer(Duration(seconds: 1), () {
      if (userModel.id != null) {
        // _handleCheckout(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(title: Text(appName)),
      body: new Container(
        padding: const EdgeInsets.all(20.0),
        child: new Form(
          key: _formKey,
          child: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                Visibility(
                  visible: false,
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Expanded(
                        child: const Text('Initalize transaction from:'),
                      ),
                      new Expanded(
                        child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new RadioListTile<int>(
                                value: 0,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChanged,
                                title: const Text('Local'),
                              ),
                              new RadioListTile<int>(
                                value: 1,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChanged,
                                title: const Text('Server'),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),

                ////////////////////END OF INITIALIZATION//////////
                // _border,
                // _verticalSizeBox,
                // new TextFormField(
                //   decoration: const InputDecoration(
                //     border: const UnderlineInputBorder(),
                //     labelText: 'Card number',
                //   ),
                //   onSaved: (String? value) => _cardNumber = value,
                // ),
                _verticalSizeBox,
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    // new Expanded(
                    //   child: new TextFormField(
                    //     decoration: const InputDecoration(
                    //       border: const UnderlineInputBorder(),
                    //       labelText: 'CVV',
                    //     ),
                    //     onSaved: (String? value) => _cvv = value,
                    //   ),
                    // ),
                    //  _horizontalSizeBox,
                    // new Expanded(
                    //   child: new TextFormField(
                    //     decoration: const InputDecoration(
                    //       border: const UnderlineInputBorder(),
                    //       labelText: 'Expiry Month',
                    //     ),
                    //     onSaved: (String? value) =>
                    //         _expiryMonth = int.tryParse(value ?? ""),
                    //   ),
                    // ),
                    // _horizontalSizeBox,
                    // new Expanded(
                    //   child: new TextFormField(
                    //     decoration: const InputDecoration(
                    //       border: const UnderlineInputBorder(),
                    //       labelText: 'Expiry Year',
                    //     ),
                    //     onSaved: (String? value) =>
                    //         _expiryYear = int.tryParse(value ?? ""),
                    //   ),
                    // )
                  ],
                ),
                _verticalSizeBox,
                Theme(
                  data: Theme.of(context).copyWith(),
                  child: Builder(
                    builder: (context) {
                      return _inProgress
                          ? new Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              child: Platform.isIOS
                                  ? new CupertinoActivityIndicator()
                                  : new CircularProgressIndicator(),
                            )
                          : new Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // _getPlatformButton(
                                //     'Charge Card', () => _startAfreshCharge()),
                                _verticalSizeBox,
                                _border,
                                new SizedBox(
                                  height: 40.0,
                                ),

                                Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: loadImage(
                                          url: widget
                                              .serviceModel.service_picture!,
                                          width: double.infinity,
                                          height: 150),
                                    ),
                                    _verticalSizeBox,
                                    Text(
                                      widget.serviceModel.service_title!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Divider(),

                                    Text(
                                      "Select price",
                                      style: TextStyle(),
                                    ),

                                    // Text(
                                    //   nairaSign +
                                    //       " " +
                                    // addCommer(widget
                                    //     .serviceModel.service_price!),
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 20),
                                    // ),

                                    DropdownButton<String>(
                                      isExpanded: true,
                                      value: dropdownvalue,
                                      items: <String>[
                                        nairaSign +
                                            addCommer(widget
                                                .serviceModel.service_price!),
                                        nairaSign +
                                            addCommer(widget
                                                .serviceModel.lower_price!)
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          alignment: Alignment.center,
                                          value: value,
                                          child: Text(
                                            value,
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          dropdownvalue = value!;
                                          setPrice(value);
                                        });
                                      },
                                    )
                                  ],
                                ),

                                Visibility(
                                  visible: userModel.id == null,
                                  child: Form(
                                      key: _formKey2,
                                      child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(children: [
                                          TextFormField(
                                            decoration: InputDecoration(
                                                labelText: "Enter your name"),
                                            controller: nameController,
                                            // ignore: body_might_complete_normally_nullable
                                            validator: (value) {
                                              if (value!.length < 2) {
                                                return "Name too short";
                                              }
                                            },
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                                labelText: "Enter your email"),
                                            controller: emailController,
                                            validator: (value) {
                                              bool emailValid = RegExp(
                                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(value!);

                                              if (!emailValid) {
                                                return "Invalid email";
                                              }
                                            },
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                                labelText:
                                                    "Enter phone number"),
                                            controller: phoneController,
                                            validator: (value) {
                                              if (value!.length < 6) {
                                                return "phone number too short";
                                              }
                                            },
                                          )
                                        ]),
                                      )),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  child: _getPlatformButton('Checkout', () {
                                    if (userModel.id == null) {
                                      if (_formKey2.currentState!.validate()) {
                                        _handleCheckout(context);
                                      }
                                    } else {
                                      _handleCheckout(context);
                                    }
                                  }),
                                ),
                                // new Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: <Widget>[
                                // new Flexible(
                                //   flex: 3,
                                //   child: new DropdownButtonHideUnderline(
                                //     child: new InputDecorator(
                                //       decoration: const InputDecoration(
                                //         border: OutlineInputBorder(),
                                //         isDense: true,
                                //         hintText: 'Checkout method',
                                //       ),
                                //       child: new DropdownButton<
                                //           CheckoutMethod>(
                                //         value: _method,
                                //         isDense: true,
                                //         onChanged: (CheckoutMethod? value) {
                                //           if (value != null) {
                                //             setState(() => _method = value);
                                //           }
                                //         },
                                //         items: banks.map((String value) {
                                //           return new DropdownMenuItem<
                                //               CheckoutMethod>(
                                //             value:
                                //                 _parseStringToMethod(value),
                                //             child: new Text(value),
                                //           );
                                //         }).toList(),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // _horizontalSizeBox,
                                // new Flexible(
                                //   flex: 1,
                                //   child: new
                                // ),
                                //   ],
                                // )
                              ],
                            );
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

  void _handleRadioValueChanged(int? value) {
    if (value != null) setState(() => _radioValue = value);
  }

  _handleCheckout(BuildContext context) async {
    if (_method != CheckoutMethod.card && _isLocal) {
      _showMessage('Select server initialization method at the top');
      return;
    }
    setState(() => _inProgress = true);
    _formKey.currentState?.save();
    Charge charge = Charge()
      ..amount = amount!
      // In base currency
      ..email = userModel.id != null ? userModel.email : emailController.text
      ..addParameter(
          "phon number",
          userModel.phoneNumber != null
              ? userModel.phoneNumber!
              : phoneController.text)
      ..addParameter(
          "name",
          userModel.username != null
              ? userModel.username!
              : nameController.text)
      ..card = _getCardFromUI();

    if (!_isLocal) {
      var accessCode = await _fetchAccessCodeFrmServer(_getReference());
      charge.accessCode = accessCode;
    } else {
      charge.reference = _getReference();
    }

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: false,
        logo: MyLogo(),
      );
      print('Response = $response');
      setState(() => _inProgress = false);
      _updateStatus(response.reference, '$response');
    } catch (e) {
      setState(() => _inProgress = false);
      _showMessage("Check console for error");
      rethrow;
    }
  }

  postOrder(reference) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(now);

    var request =
        await http.post(Uri.parse(root_domain + "post_order.php"), body: {
      "post_order": "post_order",
      "user_id": userModel.id,
      "username": userModel.username,
      "service_title": widget.serviceModel.service_title,
      "service_picture": widget.serviceModel.service_picture,
      "service_price": paidPrice,
      "order_date": formattedDate,
      "order_ref": reference,
      "order_status": "pending"
    });

    if (request.statusCode == 200) {
      var response = jsonDecode(request.body);
      if (response['status'] == true) {
        showAlertDialog(context, "Payment was posted successfully");
      } else {
        showAlertDialog(context, "Payment was not posted");
        setState(() {});
      }
    }
  }

  _startAfreshCharge() async {
    _formKey.currentState?.save();

    Charge charge = Charge();
    charge.card = _getCardFromUI();

    setState(() => _inProgress = true);

    if (_isLocal) {
      // Set transaction params directly in app (note that these params
      // are only used if an access_code is not set. In debug mode,
      // setting them after setting an access code would throw an exception

      charge
        ..amount = 10000 // In base currency
        ..email = 'customer@email.com'
        ..reference = _getReference()
        ..putCustomField('Charged From', 'Flutter SDK');
      _chargeCard(charge);
    } else {
      // Perform transaction/initialize on Paystack server to get an access code
      // documentation: https://developers.paystack.co/reference#initialize-a-transaction
      charge.accessCode = await _fetchAccessCodeFrmServer(_getReference());
      _chargeCard(charge);
    }
  }

  _chargeCard(Charge charge) async {
    final response = await plugin.chargeCard(context, charge: charge);

    final reference = response.reference;

    // Checking if the transaction is successful
    if (response.status) {
      _verifyOnServer(reference);

      return;
    }

    // The transaction failed. Checking if we should verify the transaction
    if (response.verify) {
      _verifyOnServer(reference);
    } else {
      setState(() => _inProgress = false);
      _updateStatus(reference, response.message);
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  showAlertDialog(BuildContext context, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text(
        msg,
      ),
      actions: [
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

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );

    // Using Cascade notation (similar to Java's builder pattern)
//    return PaymentCard(
//        number: cardNumber,
//        cvc: cvv,
//        expiryMonth: expiryMonth,
//        expiryYear: expiryYear)
//      ..name = 'Segun Chukwuma Adamu'
//      ..country = 'Nigeria'
//      ..addressLine1 = 'Ikeja, Lagos'
//      ..addressPostalCode = '100001';

    // Using optional parameters
//    return PaymentCard(
//        number: cardNumber,
//        cvc: cvv,
//        expiryMonth: expiryMonth,
//        expiryYear: expiryYear,
//        name: 'Ismail Adebola Emeka',
//        addressCountry: 'Nigeria',
//        addressLine1: '90, Nnebisi Road, Asaba, Deleta State');
  }

  Widget _getPlatformButton(String string, Function() function) {
    // is still in progress
    Widget widget;
    if (Platform.isIOS) {
      widget = new CupertinoButton(
        onPressed: function,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: CupertinoColors.activeBlue,
        child: new Text(
          string,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      widget = new ElevatedButton(
        onPressed: function,
        child: new Text(
          string.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
    return widget;
  }

  Future<String?> _fetchAccessCodeFrmServer(String reference) async {
    String url = '$backendUrl/new-access-code';
    String? accessCode;
    try {
      print("Access code url = $url");
      http.Response response = await http.get(Uri.parse(url));
      accessCode = response.body;
      print('Response for access code = $accessCode');
    } catch (e) {
      setState(() => _inProgress = false);
      _updateStatus(
          reference,
          'There was a problem getting a new access code form'
          ' the backend: $e');
    }

    return accessCode;
  }

  void _verifyOnServer(String? reference) async {
    _updateStatus(reference, 'Verifying...');
    String url = '$backendUrl/verify/$reference';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var body = response.body;
      _updateStatus(reference! + "sucess", body);
      String msg = "Payment was successful, we will call you shortly " +
          "or you can call us to fasten the process";

      showAlertDialog(context, msg);
      if (userModel.id != null) {
        postOrder(reference);
      }
    } catch (e) {
      _updateStatus(
          reference,
          'There was a problem verifying %s on the backend: '
          '$reference $e');
    }
    setState(() => _inProgress = false);
  }

  _updateStatus(String? reference, String message) {
    _showMessage('Reference: $reference \n\ Response: $message',
        const Duration(seconds: 10));
  }

  _showMessage(String message,
      [Duration duration = const Duration(seconds: 2)]) {
    // ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
    //   content: new Text(message),
    //   duration: duration,
    //   action: new SnackBarAction(
    //       label: 'CLOSE',
    //       onPressed: () =>
    //           ScaffoldMessenger.of(context).removeCurrentSnackBar()),
    // ));
  }

  bool get _isLocal => _radioValue == 0;
}

var banks = ['Selectable', 'Bank', 'Card'];

CheckoutMethod _parseStringToMethod(String string) {
  CheckoutMethod method = CheckoutMethod.selectable;
  switch (string) {
    case 'Bank':
      method = CheckoutMethod.bank;
      break;
    case 'Card':
      method = CheckoutMethod.card;
      break;
  }
  return method;
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Image.asset(
        "assets/images/favicon.png",
        height: 30,
        width: 30,
      ),
    );
  }
}

const Color green = const Color(0xFF3db76d);
const Color lightBlue = const Color(0xFF34a5db);
const Color navyBlue = const Color(0xFF031b33);
