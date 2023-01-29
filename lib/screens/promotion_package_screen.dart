import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/paypal_payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';
import 'dashboard.dart';
import 'home_screen.dart';

class PromotionPackage extends StatefulWidget {
  const PromotionPackage({Key? key}) : super(key: key);

  @override
  _PromotionPackageState createState() => _PromotionPackageState();
}

class _PromotionPackageState extends State<PromotionPackage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore(String? val, int a) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values

    if (a == 1) {
      userModel.payment = "10.99";
      userModel.type = "ARTIST/PRODUCER";
    } else {
      userModel.payment = "73.99";
      userModel.type = "RECORD LABEL";
    }
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .update(userModel.toMapPayment());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Graphics2.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Container(
                  width: 450,
                  height: 350,
                  decoration: BoxDecoration(
                    color: const Color(0xFF161616).withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            '   ARTIST/PRODUCER',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Unlimited Releases',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • B-Side Tracks',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Global Digital Distribution',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Youtube Content ID',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Profile/Smart Link & Pre-save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • PC/ISRC Code',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Sales Analytics inc Monthly Payouts',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Project Funding',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Dedicated Team when you need us',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '     10.99 GDP',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32, 0, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Most Popular',
                              style: TextStyle(color: Colors.white),
                            ),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFFFFFFF),
                              child: MaterialButton(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                minWidth: 150,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PaypalPayment(
                                        onFinish: (number) async {
                                          // payment done
                                          print('order id: ' + number);
                                          postDetailsToFirestore(
                                              number.toString(), 1);
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "JOIN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 450,
                  height: 350,
                  decoration: BoxDecoration(
                    color: const Color(0xFF161616).withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            '   RECORD LABEL',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Unlimited Releases',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • 10 Artist',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Full Label Support',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Global Digital Distribution',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Youtube Content ID',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Profile/Smart Link & Pre-save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • PC/ISRC Code',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Sales Analytics inc Monthly Payouts',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '        • Dedicated Team when you need us',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '     73.99 GDP',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(32, 0, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('                        '),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                              child: MaterialButton(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  minWidth: 150,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PaypalPaymentRecord(
                                          onFinish: (number) async {
                                            // payment done
                                            print('order id: ' + number);
                                            postDetailsToFirestore(
                                                number.toString(), 2);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "JOIN",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: 200,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()));
                      },
                      child: const Text(
                        "ALREADY MEMBER",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFFFFFFF),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
