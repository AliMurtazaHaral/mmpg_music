import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/setting_page.dart';
import 'package:music_app/screens/signup_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';
import 'login_screen.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final collectionRefernce = FirebaseFirestore.instance.collection('users');
  final _formKey = GlobalKey<FormState>();
  // firebase
  final _auth = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(_auth!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  Future<void> deleteUserAccount(String email, String pass) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pass);
    await _auth!.reauthenticateWithCredential(credential).then((value) {
      value.user!.delete().then((res) {
        collectionRefernce.doc(loggedInUser.uid.toString()).delete().then(
              (value) =>
                  Fluttertoast.showToast(msg: "Account Deleted Successfully"),
            );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpLogin()));
      });
    }).catchError((onError) => Get.snackbar("Credential Error", "Failed"));
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
            'Delete Account',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
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
                            height: 400,
                            decoration: const BoxDecoration(
                              color: Color(0xFF161616),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Delete Account",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    "Are you sure you want to delete your account",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                    child: MaterialButton(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 15, 20, 15),
                                        minWidth: 300,
                                        onPressed: () {
                                          deleteUserAccount(
                                              loggedInUser.email.toString(),
                                              loggedInUser.password.toString());
                                        },
                                        child: const Text(
                                          "Delete Account",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                    child: MaterialButton(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 15),
                                      minWidth: 300,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Cancel",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
        ),
      ),
    );
  }
}
