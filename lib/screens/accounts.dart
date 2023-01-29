import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_app/screens/paypal_connection_page.dart';
import 'package:music_app/screens/paypal_payment.dart';
import '../model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reEnterNewController = TextEditingController();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  void checker() {
    if (reEnterNewController.text == newPasswordController.text) {
      passwordChange(loggedInUser.email.toString(), oldPasswordController.text);
    }
  }

  void passwordChange(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                password = newPasswordController.text,
                Fluttertoast.showToast(msg: "Password change Successfully"),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Account',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF161616),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 450,
                              decoration: const BoxDecoration(
                                color: Color(0xFF161616),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        "Account Details",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(
                                        "This is your real name and contact information",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        "Full Name                          ${loggedInUser.fullName}",
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        "Email Address                  ${loggedInUser.email}",
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        "Password",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      child: Text(
                                        "If you wish to change your secure account password, please enter your current"
                                        "\npassword and then the new one below",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 9),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    autofocus: false,
                                    controller: oldPasswordController,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please Enter Old Password");
                                      }
                                      // reg expression for email validation
                                      return null;
                                    },
                                    onSaved: (value) {
                                      oldPasswordController.text = value!;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xFF161616),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 15),
                                      hintText: "Enter Your Old Password",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    autofocus: false,
                                    controller: newPasswordController,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please Enter Your New Password");
                                      }
                                      // reg expression for email validation
                                      return null;
                                    },
                                    onSaved: (value) {
                                      newPasswordController.text = value!;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xFF161616),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 15),
                                      hintText: "Enter Your New Password",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    autofocus: false,
                                    controller: reEnterNewController,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please re-Enter Your new Password");
                                      }
                                      // reg expression for email validation
                                      return null;
                                    },
                                    onSaved: (value) {
                                      reEnterNewController.text = value!;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xFF161616),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 15),
                                      hintText: "Reenter Your New Password",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(""),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                checker();
                                              },
                                              child: Row(
                                                children: const [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "Update Account Details ",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.blue,
                                                    size: 12,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF161616),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 450,
                            decoration: const BoxDecoration(
                              color: Color(0xFF161616),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      "Payment Details",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Text(
                                      "To get paid, connect your paypal",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(
                                          "Account",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PayoutPage()));
                                      },
                                      child: Row(
                                        children: const [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "                           Connect to paypal ",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 145, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 0, 20),
                                          child: Text(
                                            "Payee Name",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 0, 20),
                                          child: Text(
                                            "${loggedInUser.fullName}",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 191, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 0, 20),
                                          child: Text(
                                            "Payment Currency",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 0, 20),
                                          child: Text(
                                            "GBP",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Text(
                                      "Country                                United Kingdom",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(""),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Row(
                                              children: const [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "Update Payment Details ",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.blue,
                                                  size: 12,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF161616),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 450,
                            decoration: const BoxDecoration(
                              color: Color(0xFF161616),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      "Subscription",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Text(
                                      "My subscription history",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      "Type                                ${loggedInUser.type}",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                                    child: Text(
                                      "Status                             Paid",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 20),
                                    child: Text(
                                      "Amount                           ${loggedInUser.payment}",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Text(
                                      "Due Date                         1/1/2023",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(""),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Row(
                                              children: const [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "View Details ",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.blue,
                                                  size: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
