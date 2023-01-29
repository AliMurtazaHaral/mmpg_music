import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Membership2 extends StatefulWidget {
  const Membership2({Key? key}) : super(key: key);

  @override
  _Membership2State createState() => _Membership2State();
}

class _Membership2State extends State<Membership2> {
  final _formKey = GlobalKey<FormState>();
  // firebase
  final _auth = FirebaseAuth.instance;
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
            'Membership',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            child: Container(
              width: 450,
              height: 350,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        '   ARTIST/PRODUCER',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 70,
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
                  Row(
                    children: [
                      const SizedBox(
                        width: 32,
                      ),
                      const Text(
                        'Most Popular',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 150,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFFFFFFF),
                        child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: 150,
                          onPressed: () {},
                          child: const Text(
                            "MEMBER",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
