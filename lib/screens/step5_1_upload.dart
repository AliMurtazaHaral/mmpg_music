import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/realtime_database_model.dart';
import 'package:music_app/screens/add_lyrics_screen.dart';
import 'package:music_app/screens/step4_uplaod.dart';
import 'package:music_app/screens/step5_upload.dart';
import 'package:music_app/screens/step6_upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';
import 'dashboard.dart';

class Step51Upload extends StatefulWidget {
  final String? docid;
  final String? title;
  const Step51Upload({Key? key, required this.docid, required this.title})
      : super(key: key);

  @override
  _Step51UploadState createState() => _Step51UploadState();
}

class _Step51UploadState extends State<Step51Upload> {
  final tTitleController = TextEditingController();
  String parentalAdvistoyController = "Explicit";
  final copyrightController = TextEditingController();
  final copyright1Controller = TextEditingController();
  final isrcController = TextEditingController();
  final primaryArtistController = TextEditingController();
  final roleController = TextEditingController();
  final writerController = TextEditingController();
  DatabaseModel databaseModel = DatabaseModel();
  final _auth = FirebaseAuth.instance;
  String dropdownvalue = 'SELECT';

  // List of items in our dropdown menu
  var items = [
    'SELECT',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  var parentalAdvisory = [
    'Explicit',
    'Non Explicit',
  ];

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.trackTitle = tTitleController.text;
    userModel.parentalAdvistory = parentalAdvistoyController;
    userModel.copyrightHolder =
        copyrightController.text + copyrightController.text;
    userModel.isrc = isrcController.text;
    userModel.primaryArtist = primaryArtistController.text;
    userModel.role = roleController.text;
    userModel.writer = writerController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("songs")
        .doc(widget.docid)
        .update(userModel.toMap5_1());
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
                          databaseModel.s5(
                              tTitleController.text.toString(),
                              parentalAdvistoyController.toString(),
                              copyrightController.text.toString(),
                              isrcController.text.toString(),
                              primaryArtistController.text.toString(),
                              roleController.text.toString(),
                              writerController.text.toString());
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
                          'Step 5',
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
                "      Track Information",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "        Add information to each of your tracks"
                "\n\n        This is where you'll add details for individual tracks, such as title track artists"
                "\n        and contributors.",
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: Image.asset(
                "assets/fifth.PNG",
                width: 500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '          Title',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'Artist',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '     Title',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Artists',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Length              ',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '     ${widget.title}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const Text(
                          '',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Row(
                          children: [
                            Text(
                              '03:45      ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Icon(
                              Icons.play_arrow,
                              size: 40.0,
                              color: Colors.white70,
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Divider(
                        color: Colors.grey,
                        height: 1,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "    Track Details",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "        Enter the details for your track here",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "      Track Title",
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
                        controller: tTitleController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter title");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          tTitleController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          fillColor: Color(0xFF282828),
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Give your track title",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
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
                            "      Parental Advisory",
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
                      child: DecoratedBox(
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
                          items: parentalAdvisory.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(items)),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              parentalAdvistoyController = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "      Copyright Holder",
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 100,
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
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  hintText: "yyyy",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Image.asset("assets/copyright.PNG",
                              width: 20, height: 20),
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
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "who owns sound recording",
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
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "      ISRC",
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
                        controller: isrcController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter copyright holder");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          isrcController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          fillColor: Color(0xFF282828),
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "MMPG will provide ISRC for you",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "      Primary Artist",
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
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "        There name will appear on the release",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
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
                                      padding: EdgeInsets.all(10),
                                      child: Text(items)),
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
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
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
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "    Featured Artist",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF161616),
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
                    const SizedBox(
                      height: 40,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "    Additional Contributors",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "        Additional contributors are those who have made some contributions to your\n"
                        "        release but are not primary or featured artists. You can credit producers,\n"
                        "        engineers & remixers here.",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "     Role",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            elevation: 5,
                            color: const Color(0xFF009AEE),
                            child: MaterialButton(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              minWidth: 100,
                              onPressed: () {
                                //signIn(emailController.text, passwordController.text);
                              },
                              child: const Text(
                                "Producer",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              autofocus: false,
                              controller: roleController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Please enter name");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                roleController.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                fillColor: Color(0xFF282828),
                                filled: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Please enter name",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: null,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                          Image.asset(
                            "assets/delete5.PNG",
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF161616),
                        child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: 180,
                          onPressed: () {
                            //signIn(emailController.text, passwordController.text);
                          },
                          child: const Text(
                            "+ ADD ANOTHER CONTRIBUTORS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
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
                        "    Songwriters",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "        Songwriter credit must be full (first and last) names as opposed to stage names",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "      Writer",
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
                        controller: writerController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter name");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          writerController.text = value!;
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF161616),
                        child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: 180,
                          onPressed: () {
                            //signIn(emailController.text, passwordController.text);
                          },
                          child: const Text(
                            "+ ADD ANOTHER WRITER",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset("assets/lyrics.PNG"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "        Lyrics uploaded with your release will be delivered to selected"
                        "\n        platform. Please keep the following in mind as you upload your"
                        "\n        release:\n\n"
                        "           • If you'd like to include your lyrics with your release, please ensure they\n"
                        "           have been added before submitting your release.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF161616),
                        child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: 180,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddLyrics(
                                          docid: widget.docid,
                                        )));
                            //signIn(emailController.text, passwordController.text);
                          },
                          child: const Text(
                            "+ ADD LYRICS TO THIS TRACK",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(1),
                          color: const Color(0xFF009AEE),
                          child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: 180,
                            onPressed: () {
                              databaseModel.s5(
                                  tTitleController.text.toString(),
                                  parentalAdvistoyController.toString(),
                                  copyrightController.text.toString(),
                                  isrcController.text.toString(),
                                  primaryArtistController.text.toString(),
                                  roleController.text.toString(),
                                  writerController.text.toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Step6Upload(docid: widget.docid)));
                              //signIn(emailController.text, passwordController.text);
                            },
                            child: const Text(
                              "Save and close",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
