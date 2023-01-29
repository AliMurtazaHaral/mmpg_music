import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/dashboard.dart';
import 'package:music_app/screens/promotion_package_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({Key? key}) : super(key: key);

  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  UserModel userModel = UserModel();
  User? user = FirebaseAuth.instance.currentUser;
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Graphics.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Image.asset(
                        "assets/logo1.png",
                        fit: BoxFit.contain,
                        width: 90,
                        height: 130,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.26,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "LET'S GET YOU \n     STARTED!",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    '"You are one step away\n       from greatness"',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.125,
                ),
                const Text('LEARN MORE', style: TextStyle(color: Colors.white)),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                  onPressed: () {
                    if (userModel.payment != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PromotionPackage()));
                    }
                  },
                  child: Image.asset("assets/promotionButton.PNG"),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Image.asset(
                    "assets/logo1.png",
                    width: 90,
                    height: 130,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
