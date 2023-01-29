import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/dashboard.dart';
import 'package:music_app/screens/step4_uplaod.dart';
import 'package:music_app/screens/step5_1_upload.dart';
import 'package:music_app/screens/step6_upload.dart';
import 'package:music_app/screens/storage_class.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Step5Upload extends StatefulWidget {
  final String? docid;
  const Step5Upload({Key? key, required this.docid}) : super(key: key);

  @override
  _Step5UploadState createState() => _Step5UploadState();
}

class _Step5UploadState extends State<Step5Upload> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late Stream<QuerySnapshot<Map<String, dynamic>>> draftSongs;
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
    final Storage storage = Storage();
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
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 190, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Title',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Artist',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: draftSongs,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                int a = int.parse("${snapshot.data?.docs.length}");
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: a,
                      itemBuilder: (BuildContext context, int index) {
                        return (snapshot.data?.docs[index]["releaseTitle"] !=
                                    "" &&
                                snapshot.data?.docs[index]["pending"] == "")
                            ? Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 40, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.data?.docs[index]
                                                ["releaseTitle"],
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Step51Upload(
                                                            docid: widget.docid,
                                                            title: snapshot
                                                                .data
                                                                ?.docs[index][
                                                                    "releaseTitle"]
                                                                .toString(),
                                                          )),
                                                );
                                              },
                                              child: Row(
                                                children: const [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "Edit track info",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 12,
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
                                                postDetailsToFirestore();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Dashboard()),
                                                );
                                              },
                                              child: Image.asset(
                                                "assets/deleteButton.PNG",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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

                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 30,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Step6Upload(docid: widget.docid)));
                    //signIn(emailController.text, passwordController.text);
                  },
                  child: const Text(
                    "+ ADD TRACKS",
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
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
                                          builder: (context) => Step4Upload(
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
                                      fontWeight: FontWeight.normal),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Step6Upload(
                                                docid: widget.docid)));
                                    //signIn(emailController.text, passwordController.text);
                                  },
                                  child: const Text(
                                    "Next",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
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

  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.releaseTitle = "";

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("songs")
        .doc(widget.docid)
        .update(userModel.toMap1());
  }
}
