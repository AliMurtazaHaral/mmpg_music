import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_app/screens/dashboard.dart';
import 'package:music_app/screens/home_page.dart';
import 'package:music_app/screens/step1_upload.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:music_app/screens/step2_upload.dart';
import 'package:music_app/screens/step3_upload.dart';
import 'package:music_app/screens/step4_uplaod.dart';
import 'package:music_app/screens/step5_upload.dart';

import '../model/realtime_database_model.dart';
import '../model/user_model.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late Stream<QuerySnapshot<Map<String, dynamic>>> draftSongs;
  final releaseTitleController = TextEditingController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> pendings = FirebaseFirestore
      .instance
      .collection('users')
      .doc(user!.uid)
      .collection("songs")
      .snapshots();
  int pending = 0, released = 0;
  DatabaseModel databaseModel = DatabaseModel();
  late firebase_storage.Reference getUrl;
  postDetailsToFirestore1() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    userModel.pending = "";
    userModel.releaseLabel = "";
    userModel.audioReference = "";
    userModel.releaseTitle = "";
    userModel.imageReference = "";
    userModel.upc = "";
    userModel.isrc = "";
    userModel.primaryArtist = "";
    userModel.copyrightHolder = "";
    userModel.title = "";
    userModel.genre = "";
    userModel.trackTitle = "";
    userModel.parentalAdvistory = "";
    userModel.writer = "";
    userModel.role = "";
    userModel.lyrics = "";
    userModel.type = "";
    userModel.smartLink = "";
    userModel.collaboratorArtist = "";
    userModel.collaboratorEmail1 = "";
    userModel.collaboratorEmail2 = "";
    userModel.revenueShareArtist = "";
    userModel.revenueShareEmail1 = "";
    userModel.revenueShareEmail2 = "";
    userModel.releasePlan = "";
    userModel.date = "";
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection('songs')
        .add(userModel.toMapUpload());
  }

  @override
  void initState() {
    super.initState();
    draftSongs = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection("songs")
        .snapshots();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
          },
        ),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text('Uploader'),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset("assets/uploader.PNG"),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF161616),
                    ),
                    width: 450,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        const Text(
                          'Create a New Release',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Start a new process of getting your music out to the world!\n        Make sure you have everything you need to start',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF009AEE),
                          child: MaterialButton(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              minWidth: 180,
                              onPressed: () {
                                postDetailsToFirestore1();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Splash()));
                                //signIn(emailController.text, passwordController.text);
                              },
                              child: const Text(
                                "START",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        const SizedBox(
                          height: 80,
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
                            '     Your Drafts',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Below are your drafts. Once you have completed them, they will move from here to your catalogue',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 40, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Title',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Status',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Action',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder(
                          stream: draftSongs,
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            int len = int.parse(
                                "${streamSnapshot.data?.docs.length}");
                            return Container(
                              padding: const EdgeInsets.all(20),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: len,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return (streamSnapshot.data?.docs[index]
                                                    ["releaseTitle"] !=
                                                "" &&
                                            streamSnapshot.data?.docs[index]
                                                    ["pending"] ==
                                                "")
                                        ? Column(
                                            key: ValueKey(streamSnapshot
                                                .data?.docs[index].id),
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        streamSnapshot.data!
                                                                .docs[index]
                                                            ["audioReference"],
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Draft",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          print(
                                                              'Thsi si id ${streamSnapshot.data?.docs[index].id.toString()}');
                                                          if (loggedInUser
                                                                  .currentPage
                                                                  .toString() ==
                                                              "1") {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Step1Upload(
                                                                        docid: streamSnapshot
                                                                            .data
                                                                            ?.docs[index]
                                                                            .id),
                                                              ),
                                                            );
                                                          } else if (loggedInUser
                                                                  .currentPage
                                                                  .toString() ==
                                                              "2") {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Step2Upload(
                                                                      docid: streamSnapshot
                                                                          .data
                                                                          ?.docs[
                                                                              index]
                                                                          .id)),
                                                            );
                                                          } else if (loggedInUser
                                                                  .currentPage
                                                                  .toString() ==
                                                              "3") {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Step3Upload(
                                                                      docid: streamSnapshot
                                                                          .data
                                                                          ?.docs[
                                                                              index]
                                                                          .id)),
                                                            );
                                                          } else if (loggedInUser
                                                                  .currentPage
                                                                  .toString() ==
                                                              "4") {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Step4Upload(
                                                                      docid: streamSnapshot
                                                                          .data
                                                                          ?.docs[
                                                                              index]
                                                                          .id)),
                                                            );
                                                          } else if (loggedInUser
                                                                  .currentPage
                                                                  .toString() ==
                                                              "5") {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Step5Upload(
                                                                      docid: streamSnapshot
                                                                          .data
                                                                          ?.docs[
                                                                              index]
                                                                          .id)),
                                                            );
                                                          } else {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Step1Upload(
                                                                        docid: streamSnapshot
                                                                            .data
                                                                            ?.docs[index]
                                                                            .id),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Row(
                                                          children: const [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "Continue",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        12,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      GestureDetector(
                                                        onTap: () {
                                                          postDetailsToFirestore(
                                                              streamSnapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const UploadScreen()));
                                                        },
                                                        child: const Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                          size: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Divider(
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          )
                                        : Container();
                                  }),
                            );

                            if (streamSnapshot.connectionState ==
                                    ConnectionState.waiting ||
                                !streamSnapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return Container();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 1,
                          color: Colors.grey,
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
    );
  }

  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore(String d) async {
    User? user = _auth.currentUser;
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    userCollection.doc(user?.uid).collection('songs').doc(d).delete();
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  User? user = FirebaseAuth.instance.currentUser;
  late String lastId;
  UserModel loggedInUser = UserModel();
  late Stream<QuerySnapshot<Map<String, dynamic>>> lastSong;

  @override
  void initState() {
    super.initState();
    lastSong = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("songs")
        .snapshots();

    Timer(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Step1Upload(docid: lastId))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: lastSong,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          int len = int.parse("${streamSnapshot.data?.docs.length}");
          return Container(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: len,
                itemBuilder: (BuildContext context, int index) {
                  lastId = "${streamSnapshot.data?.docs[index].id}";
                  print(lastId);
                  return Container();
                }),
          );
        },
      ),
    );
  }
}
