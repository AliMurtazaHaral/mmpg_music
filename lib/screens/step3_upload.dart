import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/realtime_database_model.dart';
import 'package:music_app/screens/step2_upload.dart';
import 'package:music_app/screens/step4_uplaod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import '../model/user_model.dart';
import 'dashboard.dart';

class Step3Upload extends StatefulWidget {
  final String? docid;
  Step3Upload({Key? key, required this.docid}) : super(key: key);

  @override
  _Step3UploadState createState() => _Step3UploadState();
}

class _Step3UploadState extends State<Step3Upload> {
  final primaryArtistController = TextEditingController();
  DatabaseModel databaseModel = DatabaseModel();
  final _auth = FirebaseAuth.instance;
  bool valNotify = false;
  String dropdownvalue = 'SELECT';

  // List of items in our dropdown menu
  var items = ['SELECT', 'Singer', 'Producer', 'Composer'];
  void onChangeFunction(bool newValue) {
    setState(() {
      valNotify = newValue;
    });
  }

  final _formKey = GlobalKey<FormState>();
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.audioReference = primaryArtistController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("songs")
        .doc(widget.docid)
        .update(userModel.toMap3());
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
                          databaseModel
                              .s3(primaryArtistController.text.toString());
                          // passing this to our root
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
                          'Step 3',
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
                "      Release Artist",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "\nAdd artist information for your release"
                  "\n\nThis is where you'll credit the primary and featuring artist(s) present on your "
                  "release. You should only credit artists here who feature on 50% or more of the"
                  "Tracks on your release. You can add additional artist credits that are specific to"
                  "individual track on step 5.",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: Image.asset(
                "assets/thrid.PNG",
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
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "      Primary Artists",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "        Their name will be appear on the release."
                "\n        Choose Various Artists if you have 4 or more primary artists across your"
                "\n        release.",
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            buildNotification("Various Artist", valNotify, onChangeFunction),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),
            Row(
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "      Primary Artists",
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "\n        Their name will appear on the release",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: DropdownButton(
                      dropdownColor: Colors.blue,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),

                      // Array list of items
                      items: items.map((String items) {
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
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      autofocus: false,
                      controller: primaryArtistController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please enter name");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        primaryArtistController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        fillColor: Color(0xFF282828),
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Please enter name",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: 120,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Step2Upload(
                                  docid: widget.docid,
                                )));
                    //signIn(emailController.text, passwordController.text);
                  },
                  child: const Text(
                    "+ ADD ANOTHER ARTIST",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "      Featured Artists",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "\n        Their name will appear on the release",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: 180,
                  onPressed: () {
                    //signIn(emailController.text, passwordController.text);
                  },
                  child: const Text(
                    "+ ADD ANOTHER ARTIST",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
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
                            Material(
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
                                          builder: (context) => Step2Upload(
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
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.3,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  onPressed: () {
                                    postDetailsToFirestore();
                                    databaseModel.s3(primaryArtistController
                                        .text
                                        .toString());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Step4Upload(
                                                docid: widget.docid)));
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

  Padding buildNotification(String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            width: 50,
          ),
          DottedBorder(
            color: Colors.grey,
            strokeWidth: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Text(
                    "Yes",
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Transform.scale(
                    scale: 1.0,
                    child: CupertinoSwitch(
                      value: value,
                      activeColor: Colors.white70,
                      trackColor: Colors.white70,
                      onChanged: (bool newValue) {},
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "No",
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedArtist extends StatefulWidget {
  const FeaturedArtist({Key? key}) : super(key: key);

  @override
  State<FeaturedArtist> createState() => _FeaturedArtistState();
}

class _FeaturedArtistState extends State<FeaturedArtist> {
  final featuredArtistController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Featured Artist',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          autofocus: false,
          controller: featuredArtistController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Please enter title");
            }
            return null;
          },
          onSaved: (value) {
            featuredArtistController.text = value!;
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
    );
  }
}
