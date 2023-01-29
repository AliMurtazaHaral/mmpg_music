import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/dashboard.dart';
import 'package:music_app/screens/home_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';
import 'home_screen.dart';
import 'music_page.dart';

class SmartLink extends StatefulWidget {
  final String? songId;
  const SmartLink({Key? key, required this.songId}) : super(key: key);

  @override
  _SmartLinkState createState() => _SmartLinkState();
}

class _SmartLinkState extends State<SmartLink> {
  TextEditingController upcController = TextEditingController();
  TextEditingController isrcController = TextEditingController();
  String isrc = "";
  String upc = "";
  UserModel loggedInUser = UserModel();
  String url = "";
  User? user = FirebaseAuth.instance.currentUser;
  String urlS = "";
  checkISRC() {
    if (loggedInUser.isrc != null || loggedInUser.isrc == "") {
      setState(() {
        isrc = loggedInUser.isrc!;
      });
    } else {
      setState(() {
        isrc = "ISRC  isrc is not assigned";
      });
    }
  }

  checkUPC() {
    if (loggedInUser.upc != null) {
      setState(() {
        upc = loggedInUser.upc!;
      });
    } else {
      setState(() {
        upc = "UPC  upc is not assigned";
      });
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("songs")
        .doc(widget.songId)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromSongMap(value.data());
      setState(() {});
    });
    checkISRC();
    checkUPC();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "assets/Graphics.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.black,
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
                'Promote',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 250,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Smart Link',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Share your music with the world.',
                          style: TextStyle(
                              fontSize: 38,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                      child: Row(
                        children: [
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                            child: MaterialButton(
                              minWidth: 110,
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              onPressed: () {
                                Share.share(loggedInUser.smartLink.toString());
                              },
                              child: const Icon(
                                Icons.share,
                                size: 35.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                            child: MaterialButton(
                              minWidth: 110,
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: loggedInUser.smartLink));
                              },
                              child: const Icon(
                                Icons.link,
                                size: 35.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                            child: MaterialButton(
                              minWidth: 110,
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              onPressed: () {
                                _launchURL(loggedInUser.smartLink.toString());
                              },
                              child: Image.asset(
                                "assets/internet.PNG",
                                height: 35,
                                width: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF161616),
                        child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {},
                            child: const Text(
                              "ISRC  isrc is not assigned",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF161616),
                        child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {},
                            child: const Text(
                              "UPC  upc is not assigned",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 280,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                        child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: 180,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard()));
                            //signIn(emailController.text, passwordController.text);
                          },
                          child: const Text(
                            "Takedown",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
