import 'package:cleaners_app/constants.dart';
import 'package:cleaners_app/widgets/card_list.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset(
                "assets/images/contact_ill.png",
                height: 250,
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.all(5),
                  child: Container(
                    //margin: EdgeInsets.all(5),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              children: [
                                SingleData(
                                    size: size,
                                    icon: Icons.phone,
                                    text: companyModel.phone_number!),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SingleData(
                                    size: size,
                                    icon: Icons.email,
                                    text: companyModel.company_email!),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SingleData(
                                    size: size,
                                    icon: Icons.message,
                                    text: companyModel.whatsapp_number),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SingleData(
                                    size: size,
                                    icon: Icons.location_on,
                                    text: companyModel.address!),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
