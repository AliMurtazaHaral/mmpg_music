import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/realtime_database_model.dart';
import 'package:music_app/screens/step1_upload.dart';
import 'package:music_app/screens/step2_upload.dart';
import 'package:music_app/screens/step3_upload.dart';
import 'package:music_app/screens/step5_upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';
import 'dashboard.dart';

class Step4Upload extends StatefulWidget {
  final String? docid;
  Step4Upload({Key? key, required this.docid}) : super(key: key);

  @override
  _Step4UploadState createState() => _Step4UploadState();
}

class _Step4UploadState extends State<Step4Upload> {
  final titleController = TextEditingController();
  final labelController = TextEditingController();
  final upcController = TextEditingController();
  final copyrightController = TextEditingController();
  final copyright1Controller = TextEditingController();
  String genreController = 'Alternative';
  DatabaseModel databaseModel = DatabaseModel();
  final _auth = FirebaseAuth.instance;
  var genre = [
    'Alternative',
    'Afrobeats',
    'Ambient H',
    'Anime',
    'Audio Books',
    'Big Band',
    'Blues',
    'Bollywood',
    'Brazilian',
    'Children’s Music',
    'Christian & Gospel',
    'Classical',
    'Classical Crossover',
    'Comedy',
    'Country',
    'Dance',
    'Devotional & Spiritual',
    'Electronic',
    'Folk',
    'Ghazals',
    'Heavy Metal',
    'High Classical',
    'Hip Hop / Rap',
    'Indian Classical',
    'Indian Folk',
    'Indian Pop',
    'Instrumental',
    'Jazz',
    'Karaoke',
    'Latin',
    'New Age',
    'Opera',
    'Pop',
    'R&B',
    'Reggae / Dancehall',
    'Regional Indian',
    'Rock',
    'Singer/Songwriter',
    'Soca',
    'Soundtrack',
    'Spoken Word',
    'Vocal',
    'World'
  ];
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.title = titleController.text;
    userModel.releaseLabel = labelController.text;
    userModel.upc = upcController.text;
    userModel.copyrightHolder =
        copyrightController.text + copyright1Controller.text;
    userModel.genre = genreController;

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("songs")
        .doc(widget.docid)
        .update(userModel.toMap4());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          postDetailsToFirestore();
                          // passing this to our root
                          databaseModel.s4(
                              titleController.text.toString(),
                              labelController.text.toString(),
                              copyrightController.text.toString(),
                              upcController.text.toString(),
                              genreController.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard()));
                        },
                        child: Image.asset("assets/backButton.PNG"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Step 4',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "    Release information",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 19),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "\n        Add information about your release\n\n"
                "        This is where you'll add technical details for your release, such as language,\n"
                "        copyright information and genre",
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: Image.asset(
                "assets/fourth.PNG",
                width: 500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "      Title",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    " *",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                autofocus: false,
                controller: titleController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please enter title");
                  }
                  return null;
                },
                onSaved: (value) {
                  titleController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  fillColor: Color(0xFF161616),
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "Name your release",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: null,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "      Release Label",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    " *",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                autofocus: false,
                controller: labelController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please enter title");
                  }
                  return null;
                },
                onSaved: (value) {
                  labelController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  fillColor: Color(0xFF161616),
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "Name the record label you recorded with",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: null,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            Row(
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "      Copyright Holder",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    " *",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 140,
                    child: Flexible(
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        autofocus: false,
                        controller: copyrightController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter copyright holder");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          copyrightController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          fillColor: Color(0xFF282828),
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "YYYY",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: null,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Image.asset("assets/copyright.PNG", width: 20, height: 20),
                  Flexible(
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      autofocus: false,
                      controller: copyright1Controller,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please enter copyright holder");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        copyright1Controller.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        fillColor: Color(0xFF282828),
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "who owns sound recording",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: null,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "      UPC",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                autofocus: false,
                controller: upcController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please enter title");
                  }
                  return null;
                },
                onSaved: (value) {
                  upcController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  fillColor: Color(0xFF161616),
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "MMPG will provide a UPC for you",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: null,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "      Genre",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    " *",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFF161616),
              ),
              child: DropdownButton(
                dropdownColor: Colors.blue,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
                // Initial Value
                value: genreController,

                // Down Arrow Icon
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),

                // Array list of items
                items: genre.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Padding(
                        padding: EdgeInsets.all(10), child: Text(items)),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    genreController = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/homeUpload.PNG",
                          width: MediaQuery.of(context).size.width * 0.15),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF009AEE),
                                child: MaterialButton(
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.3,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Step3Upload(
                                                  docid: widget.docid,
                                                )));
                                    //signIn(emailController.text, passwordController.text);
                                  },
                                  child: const Text(
                                    "Previous",
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF009AEE),
                                child: MaterialButton(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.3,
                                  onPressed: () {
                                    postDetailsToFirestore();
                                    print("entering into step 5");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Step5Upload(
                                                  docid: widget.docid,
                                                )));
                                    //signIn(emailController.text, passwordController.text);
                                  },
                                  child: const Text(
                                    "Next",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
