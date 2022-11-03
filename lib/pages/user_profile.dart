import 'dart:async';
import 'dart:convert';

import 'package:cleaners_app/constants.dart';
import 'package:cleaners_app/model/user_model.dart';
import 'package:cleaners_app/pages/sign_in.dart';
import 'package:cleaners_app/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/logout.dart';
import '../utils/utils.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            leadingWidth: 0.0,
            leading: Container(),
            title: Container(

                ///margin: EdgeInsets.only(bottom: 100),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 0.4,
                  color: Colors.grey,
                ))),
                width: MediaQuery.of(context).size.width,

                //height: 60,
                // color: Colors.white,
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "My profile",
                      style: TextStyle(fontFamily: "Raleway"),
                    ))),
            bottom: TabBar(
              labelColor: primaryColor,
              indicatorColor: Colors.blueAccent,
              indicatorWeight: 4.0,
              tabs: [
                Tab(
                  icon: Icon(Icons.person),
                  text: "Profile",
                ),
                Tab(
                  icon: Icon(Icons.edit),
                  text: "Edit Profile",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [Mprofile(), EditProfile()],
          )),
    );
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _formKey1 = GlobalKey<FormState>();
  var _formKey2 = GlobalKey<FormState>();
  var username_ctr = TextEditingController();
  var email_ctr = TextEditingController();
  var phone_ctr = TextEditingController();
  var address_ctr = TextEditingController();
  var error_msg = "";
  var error_msg2 = "";
  String? old_password, new_password;
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    username_ctr.text = userModel.username!;
    email_ctr.text = userModel.email!;
    phone_ctr.text = userModel.phoneNumber!;
    address_ctr.text = userModel.address!;

    // TODO: implement initState
    super.initState();
  }

  updatePassword() async {
    var request =
        await http.post(Uri.parse(root_domain + "update_password.php"), body: {
      "update_password": "update_password",
      "old_password": old_password,
      "new_password": new_password,
      "user_id": userModel.id
    });

    if (request.statusCode == 200) {
      var response = jsonDecode(request.body);
      if (response['status'] == true) {
        error_msg2 = "Successfully ";
        setState(() {});

        Timer(Duration(seconds: 2), () {
          var route = MaterialPageRoute(builder: (BuildContext) => SignIn());
          Navigator.push(context, route);
        });
      } else {
        error_msg2 = response['msg'];
        setState(() {});
      }
    } else {
      error_msg2 = "Error: Please check your internet connection";
      setState(() {});
    }
  }

  void updateDetails() async {
    var request =
        await http.post(Uri.parse(root_domain + "update_user.php"), body: {
      "update_user": "update_user",
      "email": email_ctr.text,
      "phone_number": phone_ctr.text,
      "address": address_ctr.text,
      "user_id": userModel.id
    });

    if (request.statusCode == 200) {
      print(request.body);
      var response = jsonDecode(request.body);
      if (response['status'] == true) {
        userModel = UserModel.fromJson(response['data']);
        error_msg = "Successfully ";
        setState(() {});
      } else {
        error_msg = response['msg'];
        setState(() {});
      }
    } else {
      error_msg = "Error: Please check your internet connection";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.all(10),
          child: Column(children: [
            Container(
                width: size.width,
                margin: EdgeInsets.all(5),
                child: Card(
                    elevation: 3,
                    margin: EdgeInsets.all(5),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 7),
                            child: TextFormField(
                              readOnly: true,
                              controller: username_ctr,
                              decoration:
                                  InputDecoration(label: Text("Username")),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 7),
                            child: TextFormField(
                              //readOnly: true,
                              controller: phone_ctr,
                              decoration:
                                  InputDecoration(label: Text("Phone number")),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 7),
                            child: TextFormField(
                              // readOnly: true,
                              controller: email_ctr,
                              decoration: InputDecoration(label: Text("Email")),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 7),
                            child: TextFormField(
                              maxLines: 2,
                              // readOnly: true,
                              controller: address_ctr,
                              decoration:
                                  InputDecoration(label: Text("Address")),
                            ),
                          ),
                          error_msg != ""
                              ? Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    error_msg,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(),
                          Container(
                              width: size.width,
                              margin: EdgeInsets.only(bottom: 7),
                              child: MaterialButton(
                                onPressed: () {
                                  error_msg = "";
                                  setState(() {});

                                  bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(email_ctr.text);

                                  if (phone_ctr.text.trim().length < 10) {
                                    setState(() {
                                      error_msg = "Invalid phone number";
                                    });
                                  } else if (!emailValid) {
                                    setState(() {
                                      error_msg = "Invalid emial address";
                                    });
                                  } else if (phone_ctr.text.trim().length < 5) {
                                    setState(() {
                                      error_msg = "Address too short";
                                    });
                                  }

                                  updateDetails();
                                },
                                child: Text("Update"),
                                textColor: whitColor,
                                color: primaryColor,
                                shape: StadiumBorder(),
                              ))
                        ],
                      ),
                    ))),
            Container(
                width: size.width,
                margin: EdgeInsets.all(5),
                child: Card(
                    elevation: 3,
                    margin: EdgeInsets.all(5),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Form(
                        key: _formKey1,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 7),
                              child: Text(
                                "Edit Password",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 7),
                              child: TextFormField(
                                onSaved: (val) {
                                  old_password = val;
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Please fill this field";
                                  }
                                },
                                // readOnly: true,
                                // controller: username_ctr,
                                decoration: InputDecoration(
                                    label: Text("Old password")),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 7),
                              child: TextFormField(
                                validator: (val) {
                                  if (val!.length < 5) {
                                    return "password must be grater than 5 characters";
                                  }
                                },
                                onSaved: (val) {
                                  new_password = val;
                                },
                                //readOnly: true,
                                //controller: phone_ctr,
                                decoration: InputDecoration(
                                    label: Text("New Password")),
                              ),
                            ),
                            error_msg2 != ""
                                ? Container(
                                    width: size.width,
                                    margin: EdgeInsets.only(bottom: 7),
                                    child: Text(
                                      error_msg2,
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                  )
                                : Container(),
                            Container(
                                width: size.width,
                                margin: EdgeInsets.only(bottom: 7),
                                child: MaterialButton(
                                  onPressed: () {
                                    error_msg2 = "";
                                    setState(() {});
                                    if (_formKey1.currentState!.validate()) {
                                      _formKey1.currentState!.save();
                                      if (old_password! != userModel.password) {
                                        error_msg2 = "Old password no matched";
                                        setState(() {});
                                        return;
                                      }

                                      updatePassword();
                                    }
                                  },
                                  child: Text("Update password"),
                                  textColor: whitColor,
                                  color: primaryColor,
                                  shape: StadiumBorder(),
                                ))
                          ],
                        ),
                      ),
                    )))
          ])),
    );
  }
}

class Mprofile extends StatefulWidget {
  const Mprofile({Key? key}) : super(key: key);

  @override
  State<Mprofile> createState() => _MprofileState();
}

class _MprofileState extends State<Mprofile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(
              "assets/images/profile_ill2.png",
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
                                  icon: Icons.person,
                                  text: userModel.username!),
                              Divider(
                                color: Colors.grey,
                              ),
                              SingleData(
                                  size: size,
                                  icon: Icons.email,
                                  text: userModel.email!),
                              Divider(
                                color: Colors.grey,
                              ),
                              SingleData(
                                  size: size,
                                  icon: Icons.phone,
                                  text: userModel.phoneNumber),
                              Divider(
                                color: Colors.grey,
                              ),
                              SingleData(
                                  size: size,
                                  icon: Icons.location_on,
                                  text: userModel.address!),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      TextButton(
                          onPressed: () {
                            deleteDialog(context);
                          },
                          child: Text(
                            "Delete Accout",
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: false,
              child: Container(
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
                                    icon: Icons.location_on,
                                    text: userModel.address!),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  deleteDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Confirm"),
      onPressed: () async {
        var request = await http.post(
            Uri.parse(root_domain + "delete_user.php"),
            body: {"delete_user": "delete_user", "user_id": userModel.id});

        if (request.statusCode == 200) {
          showSnackBar(context, "Successfully Deleted");
        } else {
          showSnackBar(context, "Something went wrong");
        }

        setState(() {});
        Navigator.pop(context);
        logOut(userModel, context);
      },
    );

    Widget cancleButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Are you sure you want to delete this account"),
      actions: [okButton, cancleButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
